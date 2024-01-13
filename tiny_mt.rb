class TinyMT
  TINYMT32_MASK = 0x7FFFFFFF
  TINYMT32_SH0 = 1
  TINYMT32_SH1 = 10
  TINYMT32_SH8 = 8
  MIN_LOOP = 8
  PRE_LOOP = 8

  PARAMS = {
    mat1: 0x8f7011ee,
    mat2: 0xfc78ff1f,
    tmat: 0x3793fdff
  }

  def initialize(seed, param = PARAMS)
    @param = param
    if seed.is_a?(Numeric)
      init(seed)
    else
      @status = seed
    end
  end

  def init(seed)
    @status = [seed, @param[:mat1], @param[:mat2], @param[:tmat]]

    MIN_LOOP.times do |i|
      s = @status[(i - 1) & 3] ^ (@status[(i - 1) & 3] >> 30)
      @status[i & 3] ^= ((((s >> 16) * 0x6C078965) << 16) + (s & 0xffff) * 0x6C078965) + i
    end

    period_certification

    PRE_LOOP.times do
      next_state
    end
  end

  def next_state
    y = @status[3]
    x = ((@status[0] & TINYMT32_MASK) ^ @status[1] ^ @status[2])
    x ^= (x << TINYMT32_SH0)
    y ^= (y >> TINYMT32_SH0) ^ x
    @status[0] = @status[1]
    @status[1] = @status[2]
    @status[2] = x ^ (y << TINYMT32_SH1)
    @status[3] = y

    if (y & 1) == 1
      @status[1] ^= @param[:mat1]
      @status[2] ^= @param[:mat2]
    end
  end

  def temper
    t0 = @status[3]
    t1 = @status[0] + (@status[2] >> TINYMT32_SH8)
    t0 ^= t1
    t0 ^= @param[:tmat] if (t1 & 1) == 1
    t0 & 0xFFFFFFFF
  end

  def reseed(seed)
    init(seed)
  end

  def period_certification
    if @status[0] == TINYMT32_MASK && @status[1] == 0 && @status[2] == 0 && @status[3] == 0
      @status = [TINYMT32_MASK, TINYMT32_MASK, TINYMT32_MASK, TINYMT32_MASK]
    end
  end

  def get_next_32bit
    next_state
    temper
  end
end

# Example usage:
seed = 5489 # Replace with your desired seed value
twister = TinyMT.new(seed)

# Generate and print 10 random numbers
10.times do
  puts twister.get_next_32bit
end
