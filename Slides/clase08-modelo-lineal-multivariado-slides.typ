#import "@preview/polylux:0.3.1": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  footer: [LDD 2024 H1 C08]
)
#show link: set text(blue)
#show link: underline
#set text(font: "Fira Sans", weight: "light", size: 20pt, lang: "es")
#show math.equation: set text(font: "Fira Math")
#set strong(delta: 100)
#set par(justify: true)

#title-slide(
  author: [Laboratorio de Datos - Primer Cuatrimestre 2024 - FCEyN, UBA],
  title: "Modelo Lineal Multivariado: Una Introducción Práctica",
  subtitle: "Fórmulas de Wilkinson y convalidación cruzada en Python",
)

#slide(title: "Tabla de Contenidos")[
  #metropolis-outline
  #align(image("img/UBA.svg", width: 1in), right)
]
#new-section-slide([Modelo Lineal Multivariado (MLM)])
#slide(title: [MLM: M de #strike("Motomami") Modelo])[
_Modelar_ (en CD, no en la pasarela) una variable respuesta ("dependiente") $y in RR$ en función de ciertas variables explicativas ("independientes") $( x_1, dots, x_d) in RR^d$ , consiste en imponerle restricciones "útiles" a la relación (función) $y = f(x_1, dots, x_d)$.

#pause

Hemos visto modelos univariados (d=1)

$y = f(x) = beta_0 + beta_1 x$,
#pause

y polinomiales en una variable

$y = op("Poli",limits: #true)_k (x) = sum_(i=0)^k beta_i x^i = beta_0 + beta_1 x + beta_2 x^2 + dots + beta_k x^k$

#pause
Los dos son _lineales_ en $x$.
]

#slide(title:"MLM: L de Lineal")[
Un modelo $y = m(x_1, dots, x_n)$ se dice _lineal_ con _coeficientes_ $beta in RR^n$ si puede ser expresado como una combinación linea entre unos _coeficientes_ $beta$ y las $x$
$ y &= m(x_1, dots, x_n) \
&= sum_(i=1)^n beta_i dot x_i \
&= beta_0 dot 1 + beta_1 dot x_1 + dots + beta_n dot x_n
$

#pause

Esta limitación, aparentemente brutal, es más flexible de lo que parece.
]

#slide(title:"M de Multivariado")[
En el modelo univariado $y = a + b x$, $d=1$ (por definición), pero aún así, $n=2$: $beta = (a, b)$.

#pause

En el polinomial, $d=1$ y $n=k+1$ (una cuadrática tiene 3 coeficientes)

#pause

En el modelo lineal multivariado, tenemos $d$ arbitrariamente grande, y $n >= d$. Será de sumo interés tener una notación concisa cuando la relación entre $d$ y $n$ sea compleja.

]
#new-section-slide([Descripción de Modelos: Fórmulas de Wilkinson-Rodgers])
#slide(title: "Fórmulas de Wilkinson")[
  Wilkinson y Rogers, dos señores ocupados en hacer cantidades de estudios de análisis de la varianza (ANOVA), deciden sentarse a elegir una _descripción simbólica_ de los modelos:
  
  #link(" https://sci-hub.se/10.2307/2346786", "Wilkinson, G. N., & Rogers, C. E. (1973). Symbolic Description of Factorial Models for Analysis of Variance. Applied Statistics, 22(3), 392") (esto no es un link a scihub)

  #pause

  Se hicieron populares con S (el antecesor de R) y a hoy, todo _software_ de modelo lineal implementa su propia (ligera e insidiosamente diferente) _gramática de fórmulas_. 
]

#slide(title: "Formulaic: Wilkinson en Python, bien rápido")[
  En R las fórmulas son objetos de primer nivel. En python, la librería `patsy` las implementa hace tiempo ya, y en `statsmodels` se usan ampliamente. Hoy, consideraremos una implementación más reciente: `formulaic`.
  #align(center,
  [
    #image("img/clase-8-formulaic.png", width: 3in)
    #side-by-side[
      #link("https://matthewwardrop.github.io/formulaic/", "Documentación")][
      #link("https://matthewwardrop.github.io/formulaic/guides/grammar/#fnref:2", "Gramática")
    ]
    
])
]

#slide(title: "Formulaic en acción")[
  ```python
import pandas as pd
from formulaic import model_matrix

df = pd.DataFrame({
    'y': [0, 1, 2],
    'a': ['A', 'B', 'C'],
    'b': [0.3, 0.1, 0.2],
})
y, X = model_matrix("y ~ a + b + a:b", df)
# Esta es la versión taquigráfica (shorthand) de
# y, X = formulaic.Formula('y ~ a + b + a:b').get_model_matrix(df)
pd.concat([y, X], axis=1)
  ```
  #pause
  #place(top + right, image("img/ejemplo-formulaic.png"))
]

#slide(title: "¿Gramática?")[
Claro! Hete aquí una breve descripción de los operadores más usuales, comunes a (imagino) todas las implementaciones de Wilkinson-Rodgers. Todos están soportados por `formulaic`:

#set text(14pt)
#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: (center, horizon),
  table.header(
    [*Operador*], [*Ejemplo*], [*Función*],
  ),
  [$~$], [$y  op("~")  x$], [ Separa la variable (y) respuesta a la izquierda, de el/los predictor/es a la derecha (x).],
  [+], [$y  op("~")  x + z$ ],[ *Adiciona* (suma) términos al modelo.],
  [:], [$y  op("~")  x : z$ ],[ *Interacción* entre términos. $y$ es lineal en $x dot z$.],
  [\*], [$y  op("~")  x * z$ ],[ Combina *adición e interacción*. entre términos. $y op("~") x * z$ es equivalente a $y op("~") x + z + x:z$],
)
]



#slide(title: "Gramática (cont.)")[

Existen muchos más operadores, incluyendo "$-$" para la *negación* de términos (para quitarlos del modelo) y "$\^$" ó "$\*\*$" para las interacciones de términos de orden _hasta_ $n$.

#pause

`formulaic` tiene implementadas _transformaciones_ que se pueden aplicar a las variables predictoras:
- funciones arbitrarias de Python $y ~ "mi_fun"(x)$
- todo el módulo `numpy` disponible como `np` $y ~ "np.log"(x)$
- algunas transformaciones propias de `formulaic`, como `center` para darle media 0 a una variable.

#pause

Además, se pueden usar paréntesis $y op("~")  (a + b):c$ para "agrupar términos". Se aplican las reglas de la propiedad distributiva.

]

#slide(title: "¿Y el intercept?")[
  Aunque no es _obligatorio_ incluir un coeficiente constante en el modelo, es habitual hacerlo salvo contadas excepciones. En `formulaic` (y en `patsy`, y en `R`...) el intercept existe por omisión, pero se puede hacer explícito con el operador `+ 1`.

  Para _quitarlo_, naturalmente, se usa "$- 1$": $y op("~") x - 1$ resulta en el modelo $y = beta dot x$.

  #pause

  En código de `R`, pueden ver la expresión "$+ 0$" para remover la ordenada. Es un lenguaje curioso.
]

#slide(title: "Un ejemplo con pingüinos")[
  Supongamos que queremos estudiar la relación entre la masa corporal `masa` de los pingüinos registrados en el dataset `penguins`, su `sexo`, la `isla` de nacimiento y el largo de las aletas (`aleta_mm`).
  
  #pause

  Asumiendo que la masa es proporcional al _volumen_ del pingüino, puedo imaginar una relación `y ~ poly(aleta_mm, 3)`.

  #pause

  Si creo que además el _sexo_ del pingüino influye en la relación, puedo agregarlo como `y ~ poly(aleta_mm, 3) + sexo`. ¿Pero cómo cambiaría la `masa` en relación a una variable categórica?
  
]

#slide(title: [Todo será un(os) número(s): OHE, o _one-hot encoding_])[
  Una manera inmediata de transformar una variable categórica con $k$ categorías, es "embeberla", en un espacio de dimensión $k$, e identificar cada categoría con uno de los vectores canónicos de la base. 
  
  E.g.: $"sexo" in {"macho", "hembra"}$ se peude codificar en $RR^2$ como $(1, 0)$ y $(0, 1)$ respectivamente.

  Este procedimiento se denomina _one-hot encoding_, ya que el índice de la categoría "activa/caliente" se identifica con un "1" (y los demás con "0").

  #pause

  #alert("¿Qué riesgos conlleva OHE? ¿Son equivalentes todas las codificaciones posibles?")
]

#slide(title: "OHE: ¿Cómo se hace en Python?")[
  ```python
def ohe_pandas(serie):
    return pd.get_dummies(serie, prefix=serie.name).astype(int)


def ohe_gonza(serie):
    niveles = sorted(set(serie))
    ohe = pd.DataFrame({serie.name + "_" + n: (serie == n) for n in niveles})
    return ohe.astype(int)


assert all(ohe_pandas(df.a) == ohe_gonza(df.a))
ohe_gonza(df.a)
```
#pause
#place(bottom + right, image("img/ejemplo-ohe.png"))
]
#slide(title: "Un ejemplo con pingüinos (cont.)")[
  Por defecto, `formulaic` aplica OHE a las variables categóricas. Asumamos que el _contraste_ elegido es con respecto a la categoría "hembra", así que `sexo` sera `0` si el pingüino es hembra y `1` si es macho. Usando la notación $op("1")(x)$ para la _función indicadora_

  $
  op("1")(x) =  cases("1 si x es Verdadero", "0 si x es Falso")
  $
  
  ¿Qué representa `y ~ poly(aleta_mm, 3) + sexo`?

  #pause

  En ese modelo, la relación entre el largo de las aletas y la masa corporal es la misma para ambos sexos, _pero_ con una diferencia constante es entre sexos. ¿Por qué? ¿No sería más interesante _otro_ tipo de modelo?

  #pause #alert("¿Por qué no usé dos indicadoras, una para macho y otra para hembra?")
  
]

#slide(title: "Un ejemplo con pingüinos (cont.)")[
  ¿Qué representa `y ~ poly(aleta_mm, 3) * sexo`?

  #pause

  En este modelo, "se esconden" dos modelos con la misma _forma_ funcional (un polinomio de tercer grado), pero coeficientes (potencialmente) distintos término a término.

  #pause

  #alert([¿Y si escribiese `y ~ poly(aleta_mm, 3) * sexo * isla`? ¿Cuántos términos tendría?
  
  #pause
  
  ¿Y cómo elijo entre todos estos modelos?
  ])

]

#new-section-slide([Selección de Modelos: Convalidación Cruzada])

#slide(title: "Modelos alternativos")[
  En las slides anteriores, mencionamos al menos los siguientes modelos:
  #line-by-line[
    - `y ~ poly(aleta_mm, 3)`
    - `y ~ poly(aleta_mm, 3) + sexo`
    - `y ~ poly(aleta_mm, 3) * sexo`
    - `y ~ poly(aleta_mm, 3) * sexo * isla`
  ]
  #uncover("5-")[
  ¿Considerarían algún otro? ¿Más sencillo o más complejo? Y sobre todo,]
  #uncover("6-", align(center, alert("¿Cómo elegir entre ellos?")))
]
#slide(title: "Función de pérdida")[
  Toda tarea de "aprendizaje automático", "machine learning" o "inteligencia artificial", consiste en:
  #line-by-line[
    1. Tomar un problema relevante del mundo material
    2. Elegir un modelo matemático que lo represente
    3. Definir una _función de pérdida_ $"L" (beta | X)$ que mida de alguna manera cuán _bueno_ es el modelo (a través de $beta$) en relación a la realidad (vía los datos $X$).
      - En regresión, la pérdida más común es el _error cuadrático medio_ (MSE)
    4. "Aprender" los coeficientes $beta$, es decir, encontrar $beta^*$ que minimiza $L$.
    $ beta^* = op("argmin")_beta L(beta | X) $
  ]
]

#slide(title: "Nivel 0: Entrenar y evaluar sobre todo el conjunto de datos")[
  Hasta ahora, hemos entrenado nuestros modelos con un conjunto de datos $X$, y evaluado la performance _sobre los mismos datos_ de entrenamiento. En este contexto, si un modelo $M_1$ con coeficientes $beta_1$ es tan o más complejo[0] que otro $M_0$ (notemos $M_0 subset.eq M_1$) entonces _necesariamente_ $"L" ( beta_1| X ) <= L(beta_0 | X)$. #alert("¿Por qué?")

  #pause

#text(16pt)[  [0]: Hay muchas maneras de definir "complejidad": por ahora, la identificaremos con el número de coeficientes del modelo (la _dimensión_ de su vector $beta$).]
]

#slide(title: [Nivel 1: Separar en conjuntos de entrenamiento ("train") y prueba ("test")])[

  Que un modelo alcance un error muy pequeño durante el entrenamiento, puede ser tanto por mérito propio del modelo, o síntoma de una excesiva parametrización, que le permite "interpolar" o "memorizar" los datos (e.g.: si tenemos $n$ observaciones $(y_i, x_i)_(i=1)^n$, existe un polinomio $P$ de grado $n$ , tal que $"L"(P|X) = "ECM"(P(X), X) = 0$.

  #pause
  Para evitar el _sobreajuste_ (overfitting) de los modelos, es habitual dividir el conjunto de datos en dos partes mutuamente excluyentes (y conjuntamente exhaustivas, ¡nada se tira!). Entrenaremos cada modelo con los mismos datos de _train_ para obtener los $beta$ óptimos, pero seleccionaremos como "mejor" a aquél modelo que minimice $L$ sobre el conjunto de _test_.

  #pause
  La partición habitual (el "train-test split") suele ser de 80% train, 20% test (o 70/30), pero todo dependerá del contexto y el cantidad de observaciones $n$ disponible.
]

 #slide(title: [Relación entre error de entrenamiento y prueba])[ 
  #alert("¿Cómo esperan que se relacione el error de entrenamiento con el de prueba?")

  #pause

  #align(center, image("img/error-train-test.png", height: 85%))

 ]

#slide(title: [Nivel 3: Split entrenamiento - validación - prueba])[

  Como antes argumentamos que el modelo que minimiza el error de entrenamiento puede estar sobreajustándose a los datos, es igualmente posible que aquél que minimiza el error de prueba esté _sobreajustándose_ a los datos de _test_: al fin y al cabo, así fue como definimos nuestra regla de selección (minimizar el error de prueba). 

  #pause

  Para evitar este problema, se suele dividir el conjunto de datos en tres partes: _entrenamiento_, _validación_ y _test_:
  #pause
  #line-by-line[
    - Entrenamos los modelos minimizando $L$ en $X_("train")$ (los datos de entrenamiento)
    - seleccionamos el mejor minimizando $L$ en $X_("val")$ y
    - _evaluamos_ su performance "en el mundo real" con $L(beta | X_("test"))$.
  ]

  #alert("¿Qué ventajas y desventajas empíricas tiene este enfoque?")
]

#slide(title: [Nivel #strike("GOD") 4: Validación Cruzada en $k$ Pliegos ("K-fold CV")])[
  En un esquema tripartito "train-val-test", el error de `test` sólo sirve para reporte, y achica el tamaño efectivo de la muestra. Más aún, como hay un único conjunto de `test`, y todo el proceso está atravesado por ruido estocástico, la selección de modelos sigue teniendo un fuerte componente de azar.

  #pause

  Si queremos _estimar la distribución_ del error de prueba $L_"test"$ de un modelo, necesitaremos de varias _repeticiones_ del experimento. ¿Pero de dónde sacamos los datos para ello?

  #pause
  ¡Pues los reutilizamos! 
]

#slide(title: [K-fold CV, una representación gráfica])[
  #text(15pt)[En validación cruzada de $k$ pliegos ("k-fold cross-validation"), dividimos primero el conjunto de datos sólo en `train` y `test`. Luego, partimos `train` en en $k$ partes iguales, que se rotarán el papel de `validacion`: entrenamos y evaluamos el modelo $k$ veces, cada vez dejando uno distinto de los $k$ pliegos como `val` y el resto para `train`.
  ]
  #align(center, image("img/k-fold-cv.png", height: 70%))

]

#slide(title: "Mas allá: Otros tipos de CV, y aplicación en Python")[
  - K-fold CV no es la única manera de hacer CV. Existen variantes como _leave-one-out_ (LOO), _stratified_ y métodos "progresivos" para series de tiempo, entre otros.

  #pause
  -  Como cuando aprendimos a multiplicar, mejor empezar haciéndolo "a mano", sin pasar por implementaciones preexistentes. Luego, #link("https://scikit-learn.org/stable/modules/cross_validation.html", "scikit-learn") tiene implementaciones de CV para todos los gustos.
]
#focus-slide("¡Gracias!")

