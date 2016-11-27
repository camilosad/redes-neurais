require "./neuronio"

module Treinamento

  def self.iniciar(neuronios, entradas, erro_minimo, gama)
    loop do
      puts "======================="
      erros = []
      entradas.each do |entrada|
        erros_entrada = []
        neuronios.each do |n|
          erros_entrada.push( n.treinar(entrada[:vetor], entrada[:saida_desejada], gama) )
        end
        erros.push( calcular_erro(erros_entrada) )
      end
      break if erro_satisfatorio?(erros, erro_minimo)
    end

    puts "======================="
    neuronios.each { |n| puts "Neuronio #{n.valor}: #{n.sinapses.to_s}" }
    return true
  end

  def self.calcular_erro(erros)
    erros.map { |e| e * e }.reduce(:+).to_f / erros.size.to_f
  end

  def self.erro_satisfatorio?(erros, erro_minimo)
    puts "Erro: #{calcular_erro(erros)}"
    calcular_erro(erros) > erro_minimo ? false : true
  end
end