class Neuronio

  attr_accessor :sinapses, :v, :y, :erro, :gradiente

  def initialize(tamanho)
    @sinapses = gerar_sinapses_aleatorias(tamanho)
    @v = nil
    @y = nil
    @erro = nil
    @gradiente = nil
  end

  def calcular_v(x)
    v = x.zip(@sinapses).map{ |a, b| a * b }
    @v = v.reduce(:+)
  end

  def calcular_y(alpha, euler)
    @y = 1 / (1 + ( euler ** ( - alpha * @v ) ) )
  end

  def calcular_erro(saida_desejada)
    @erro = saida_desejada - @y
  end

  def calcular_gradiente_local(camada_interna, alpha, neuronios=nil)
    @gradiente = camada_interna ? gradiente_camada_interna(alpha, neuronios) : gradiente_camada_final(alpha)
  end

  def atualizar_sinapses(gama, vetor)
    d_sinapses = calcular_delta_sinapses(gama, vetor)
    @sinapses = @sinapses.zip(d_sinapses).map{ |a, b| a + b }
  end

  private

  def gerar_sinapses_aleatorias(tamanho)
    sinapses = []
    tamanho.times { sinapses.push Random.rand(2) }
    sinapses
  end

  def gradiente_camada_final(alpha)
    @erro * alpha * @y * (1 - @y)
  end

  def gradiente_camada_interna(alpha, neuronios)
    somatorio = neuronios.map { |n| n.gradiente * n.sinapses.last }.reduce(:+)
    alpha * @y * (1 - @y) * somatorio
  end

  def calcular_delta_sinapses(gama, vetor)
    vetor.map { |k| k * (gama * @gradiente) }
  end

end