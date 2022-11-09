import scipy.stats as stats
from math import factorial

#  stats.binom.pmf()

n = 2
p = 0.3
q = 1 - p

x = 1

a = factorial(n)/(factorial(n-x)*factorial(x))

b = p**x 

c = q ** (n -x )

print(a*b*c) # da 0,42 porque NO incluye x=2, que es un evento si quiero calcular AL MENOS 1 bolita
