require "./treinamento"

n1 = Neuronio.new 1
n2 = Neuronio.new 4
neuronios = [n1, n2]

entradas = [
  {vetor: [0,1,0,0,1,0,0,1,0], saida_desejada: 1},
  {vetor: [0,1,0,0,1,0,1,1,0], saida_desejada: 1},
  {vetor: [0,1,0,0,1,0,1,1,1], saida_desejada: 1},
  {vetor: [1,1,1,1,1,0,1,1,1], saida_desejada: 0},
  {vetor: [1,0,1,1,1,1,0,0,1], saida_desejada: 1},
  {vetor: [0,0,0,0,1,0,1,0,1], saida_desejada: 0},
  {vetor: [0,0,0,0,1,0,1,0,0], saida_desejada: 0},
  {vetor: [0,0,0,0,0,0,1,0,0], saida_desejada: 0}
]

Treinamento.iniciar(neuronios, entradas, 0.01, 0.5)