class Neuronio

  def initialize(tamanho)
    @sinapses = gerar_sinapses_aleatorias(tamanho)
    @v = nil
    @y = nil
    @erro = nil
    @sigmoid = nil
  end

  private
  def gerar_sinapses_aleatorias(tamanho)
    sinapses = []
    tamanho.times { sinapses.push Random.rand(2) }
    sinapses
  end

end