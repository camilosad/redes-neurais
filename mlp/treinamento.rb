module Treinamento

  # CONSTANTES
  ALPHA = 0.5.freeze
  EULER = Math.exp(1).freeze
  G = 0.6.freeze
  ERRO_MINIMO_DESEJADO = 0.1


  def self.iniciar(entradas, neuronios)
    loop do
      erros_epoca = []

      entradas.each_with_index do |entrada, index|

        puts "Treinando entrada #{index}"

        n4 = neuronios.first
        n4.calcular_v(entrada.vetor)
        n4.calcular_y(ALPHA, EULER)
        y4 = n4.y

        erros_locais = []
        neuronios_externos = neuronios[1..neuronios.size]

        neuronios_externos.each_with_index do |n, i|
          n.calcular_v([1, y4])
          n.calcular_y(ALPHA, EULER)
          n.calcular_erro(entrada.y_desejado[i])
          n.calcular_gradiente_local(false, ALPHA)
          n.atualizar_sinapses(G, [1, y4])
          erros_locais.push n.erro
        end

        n4.calcular_gradiente_local(true, ALPHA, neuronios_externos)
        n4.atualizar_sinapses(G, entrada.vetor)

        erros_epoca.push calcular_erro_medio_local(erros_locais)
      end

    break if erro_satisfatorio?(erros_epoca)
    end
  end

  private

  def self.erro_satisfatorio?(erros)
    calcular_erro_medio_epoca(erros) > ERRO_MINIMO_DESEJADO ? false : true
  end

  def self.calcular_erro_medio_epoca(erros)
    erro = erros.reduce(:+).to_f / erros.size.to_f
    puts "Erro da época: #{erro}"
    erro
  end

  def self.calcular_erro_medio_local(erros)
    erros.map { |e| e * e }.reduce(:+).to_f / erros.size.to_f
  end
end