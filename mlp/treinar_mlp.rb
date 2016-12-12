#$ ruby treinar_mlp.rb

require './treinamento'
require './neuronio'
require './entrada'

x1 = Entrada.new [1, 0, 0, 1], [0, 1, 1]
x2 = Entrada.new [1, 1, 0, 0], [1, 0, 1]
x3 = Entrada.new [1, 1, 1, 1], [0, 1, 1]
x4 = Entrada.new [0, 0, 0, 0], [0, 0, 1]

entradas = [x1, x2, x3, x4]

n4 = Neuronio.new (4)
n5 = Neuronio.new (2)
n6 = Neuronio.new (2)
n7 = Neuronio.new (2)

neuronios = [n4, n5, n6, n7]

Treinamento.iniciar(entradas, neuronios)