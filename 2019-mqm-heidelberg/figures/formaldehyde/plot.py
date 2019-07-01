#! /usr/bin/env python3
# -*- coding: utf-8 -*-
#vim-run: python3 %

import yaml
import matplotlib.pyplot as plt

plt.style.use('../plot.mplstyle')

with open('data.yaml') as f:
    data = yaml.load(f)
    for data_set in data:
        if not data_set.get('show', True): continue
        (data_set.get('energies') and
            plt.plot(data_set['energies'],
                'o',
                label=data_set.get('name')))
        (data_set.get('xlines') and
            [plt.axhline(
                y, label=data_set.get('name') if i==0 else '',
                color=data_set.get('color'))
                for i, y in enumerate(data_set.get('xlines'))])

plt.ylabel('Energy (eV)')
plt.xlabel('State')
plt.xlim([0,16])
plt.legend()
plt.savefig('plot.pdf')
plt.show()
