from setuptools import setup, Extension
from Cython.Build import cythonize

ext_modules = [
    Extension('player2', ['player2.pyx']),
    Extension('main', ['main.pyx']),
    Extension('gameC', ['gameC.pyx'])
]

setup(
    name = 'text-project',
    ext_modules=cythonize(ext_modules)
)