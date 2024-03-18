# ldd
Repositorio público de Laboratorio de Datos - LCD - 2024 S1

- TT: Martes y Viernes 14-17 Labo 1108
- TN: Martes y Viernes 18-21 Labo 1111

**Cuerpo Docente:**
- Santiago Laplagne
- Dario Elías
- Nazareno Faillace
- Gonzalo Barrera

**[Campus](https://campus.exactas.uba.ar/course/view.php?id=4308) de la materia**

## Sobre los notebooks

Recomendamos enfáticamente que aprendan a correr scripts/notebooks usando un ambiente virtual (_virtual anvironment_, o `venv`) local a sus computadoras. Existen infinidad de herramientas a este fin, (pyenv conda poetry) pero lo _más_ sencillo es usar `python`, el módulo `venv` y el manejador de paquetes estándar, `pip`.
$$
ENV_DIR=venv
python -m venv $ENV_DIR 
source $ENV_DIR/bin/activate
pip install --upgrade pip
pip install --requirement requirements.in
$$