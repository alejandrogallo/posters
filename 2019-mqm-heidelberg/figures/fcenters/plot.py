#vim-run: python3 %
import os
import matplotlib.pyplot as plt
import yaml
import copy

datafile = os.path.join(os.path.dirname(__file__), "data.yaml")
plt.style.use('../plot.mplstyle')

with open(datafile) as fd:
    data = list(yaml.load(fd))

for calc in data:
    if not calc.get('plot', True):
        continue
    x = copy.copy(sorted(calc['data'].keys()))
    y = copy.copy([calc['data'][k] for k in x])
    name = calc['name']
    print(name)
    print('\t', x, '\n\t', y)
    plt.plot(x, y, calc.get('plot-symbols', 'o--'), label=name)

plt.xlabel('')
plt.ylabel('Energy (eV)')
#plt.grid()
plt.legend()
plt.savefig('plot.pdf')
plt.savefig('plot.png')
#plt.show()
