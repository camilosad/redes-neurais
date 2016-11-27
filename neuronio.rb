class Neuronio

  attr_accessor :sinapses, :valor

  def initialize(valor)
    @sinapses = []
    @valor = valor
  end

  def iniciar_treinamento(entradas, erro_minimo, gama)
    loop do
      puts "======================="
      erros = []
      entradas.each { |x| erros.push ( treinar(x[:vetor], x[:saida_desejada], gama) ) }
      break if erro_satisfatorio?(erros, erro_minimo)
    end

    puts "======================="
    puts "W final: #{@sinapses.to_s}"
    return true
  end

  def treinar(vetor, saida_desejada, gama)
    puts "X: #{vetor.to_s}"
    puts "Y desejado: #{saida_desejada.to_s}"

    sinapses = @sinapses.any? ? @sinapses : gerar_sinapses_aleatorias(vetor)
    puts "W: #{sinapses.to_s}"

    v = calcular_v(vetor, sinapses)
    puts "V: #{v}"

    y = calcular_y(v)
    puts "Y: #{y}"

    erro = calcular_erro(y, saida_desejada)
    puts "Erro local: #{erro.to_s}"

    delta_sinapses = calcular_delta_sinapses(gama, erro, vetor)
    puts "Delta W: #{delta_sinapses}"

    atualizar_sinapses(sinapses, delta_sinapses)
    puts ""
    erro
  end

  private

  def gerar_sinapses_aleatorias(vetor)
    sinapses = []
    vetor.size.times { sinapses.push Random.rand(2) }
    sinapses
  end

  def calcular_v(vetor, sinapses)
    v = vetor.zip(sinapses).map{ |x, y| x * y }
    v.reduce(:+)
  end

  def calcular_y(v)
    v > 0 ? 1 : 0
  end

  def calcular_erro(y, saida_desejada)
    saida_desejada - y
  end

  def calcular_delta_sinapses(gama, erro, vetor)
    vetor.map{ |val| val * (gama * erro) }
  end

  def atualizar_sinapses(sinapses, delta_sinapses)
    @sinapses = sinapses.zip(delta_sinapses).map{ |x, y| x + y }
  end

  def erro_satisfatorio?(erros, erro_minimo)
    calcular_erro_medio(erros) > erro_minimo ? false : true
  end

  def calcular_erro_medio(erros)
    erros.map{ |erro| erro * erro }.reduce(:+).to_f / erros.size.to_f
  end

end