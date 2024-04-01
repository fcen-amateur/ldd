#import "@preview/polylux:0.3.1": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  footer: [LDD 2024 H1 C03]
)
#show link: set text(blue)
#show link: underline
#set text(font: "Fira Sans", weight: "light", size: 20pt, lang: "es")
#show math.equation: set text(font: "Fira Math")
#set strong(delta: 100)
#set par(justify: true)

#title-slide(
  author: [Laboratorio de Datos - Primer Cuatrimestre 2024 - FCEyN, UBA],
  title: "Shell y Git: siempre, en todas partes, al mismo tiempo",
  subtitle: "Herramientas viejas para problemas actuales",
)

#slide(title: "Tabla de Contenidos")[
  #metropolis-outline
  #align(image("img/UBA.svg", width: 1in), right)
]

#new-section-slide([Introducción])

#slide(title: "[Opcional] Sobre mí")[
  Acá se presenta el ponente, si no le da pudor. Más vale que la audiencia crea que uno sabe de lo que les habla. De tomar
#side-by-side[
    === Academia
    - Unas clases que di
    - Otra cosa que hice
  ][
    === Industria
    - Mi primer trabajo
    - Otro re piola que hice una vez
    - Y últimamente, por acá
  ]
]

#slide(title: "Sobre mí")[
#side-by-side[=== Academia][=== Industria]
#side-by-side[
    #pause
    - Ayudante de 2da, Estadística
    - Lic. en Economía
    - Mg. en Estadística Matemática
    - Docente de Apredizaje Automático (ML)
    - Ayudante de 1ra, a su servicio
  ][
    #pause
    - Analista de Negocios
    - Asesor en Análisis de Datos
    - Científico de Datos
    - Gerente de Ingeniería
    - Ingeniero AA/ML autónomo
  ]
]

#slide(title: "Sobre ustedes")[
== Perfil del Egresado de LCD
Tomado del #link("https://lcd.exactas.uba.ar/contenidos-minimos/", "plan de estudios") de la carrera:
#pause

#text(size:17pt)[
  ... cuenta con formación en un conjunto de disciplinas, enfocadas tanto en sus aspectos teóricos como *prácticos*, que le otorgan un profundo conocimiento en matemática y ciencias de la computación, fundamentalmente en los aspectos de modelado y *programación*, capacidad de abstracción, razonamiento lógico y pensamiento crítico.
  #pause
  
  El/La licenciado/a en Ciencias de Datos se desempeñará en ámbitos *públicos y privados*, (...). A su vez, estará preparado para iniciar estudios académicos de posgrado y realizar investigaciones en distintas áreas de Matemática y Computación, así como en *grupos interdisciplinarios* que trabajen en áreas de la Física, la Química, la Biología...
]
]

#new-section-slide([Nudo])
#slide(title: "Un secretos a voces")[

  La ${#stack(spacing: 3%, "reproducibilidad", "colaboración")}$ es un problema peludo en el ámbito ${#stack(spacing: 3%, "científico", "industrial")}$
]

#slide(title: "Reproducibilidad en el ámbito científico")[#link("https://www.infobae.com/estados-unidos/2023/06/26/la-experta-en-honestidad-de-harvard-fue-acusada-de-inventar-hallazgos-en-sus-investigaciones/", "La experta en honestidad de Harvard fue acusada de inventar hallazgos en sus investigaciones")

#side-by-side[ #image("img/data-colada.png")][#image("img/hbs.jpeg")]
]

#slide(title: "Reproducibilidad en el ámbito industrial")[#link("https://www.cronista.com/espana/pc-movil/chatgpt-se-volvio-loco-y-empezo-a-dar-respuestas-desubicadas-que-esta-pasando-con-la-iamasconocida/", "ChatGPT se volvió loco y empezó a dar respuestas desubicadas")
#set align(center)
#image("img/chatgpt.png", width: 70%)
#pause
"El 20 de febrero de 2024, una optimización de la experiencia del usuario *introdujo un error* en la forma en que el modelo procesa el lenguaje. (...) 
Tras identificar la causa del incidente, *lanzamos una corrección* y confirmamos que el incidente estaba resuelto".
]

#slide(title: "Colaboración en el ámbito científico")[#link("https://home.cern/science/experiments/cms", "¿Qué es el Solenoide Compacto de Muones del CERN?")
#side-by-side[#image("img/cms-low.jpeg")][ #pause
#link("https://cds.cern.ch/record/2809109/files/CERN-Brochure-2021-004-Eng.pdf", "El CMS")
 es un detector multipropósito construido alrededor de un solenoide superconductor gigante (...). La colaboración en el CMS que llevó al "descubrimiento" del bosón de Higgs es una de las más grandes colaboraciones científicas de la historia, alcanzando a 5.000 personas en 200 universidades e institutos de 50 países.
]]


#slide(title: "Colaboración en el ámbito industrial")[#link("https://dl.acm.org/doi/pdf/10.1145/2854146", "¿Por qué Google guarda billones de lineas de ódigo en un único repositorio?")
#side-by-side[#image("img/google-repo.png")][#pause
Google repository statistics, January 2015.
- Archivos Totales: 1.000 millones
- Archivos Fuente: 9 millones
- Líneas de código fuente: 2.000 millones
- Historial: 35 millones de "commits"
- Tamaño en disco: 86TB
- Commits por día laboral: 40.000
]
]


#new-section-slide[
  (Un) Desenlace: Sistemas de Control de Versiones
]
#slide(title: "CVSes: hay un montón")[
  #set align(center)
  #side-by-side[
    #pause
    Sucesivas copias de un archivo
    #image("img/msword.png", height: 40%)
    `tp0-ldd-v12_final.docx`
  ][
    #pause
    Editores con historial de versiones
    (e.g. #link("https://support.google.com/docs/answer/190843?hl=es-419&co=GENIE.Platform%3DDesktop&sjid=11750526672684631498-SA", [Google Docs]))
    #image("img/version-history.png", height: 50%)
  ][
    #pause
    #link("https://en.wikipedia.org/wiki/Distributed_version_control", align(center)[DVCS: Sistemas de Control
    de Versiones Distribuidos])
    #image("img/git-logo.png", height: 30%)
  ]
]

#slide(title: "Git")[
  === Una breve historia de Git
  #set text(size: 16pt)
  El kernel de Linux es un proyecto de software de código abierto con un alcance bastante amplio. Durante la mayor parte del mantenimiento del kernel de Linux (1991-2002), los cambios en el software se realizaban a través de parches y archivos. En el 2002, el proyecto del kernel de Linux empezó a usar un DVCS propietario llamado BitKeeper.

En el 2005, la relación entre la comunidad que desarrollaba el kernel de Linux y la compañía que desarrollaba BitKeeper se vino abajo y la herramienta dejó de ser ofrecida de manera gratuita. Esto impulsó a la comunidad de desarrollo de Linux (y en particular a Linus Torvalds, el creador de Linux) a desarrollar su propia herramienta basada en algunas de las lecciones que aprendieron mientras usaban BitKeeper. 

Desde su nacimiento en el 2005, Git ha evolucionado y madurado para ser fácil de usar y conservar sus características iniciales. Es tremendamente rápido, muy eficiente con grandes proyectos y tiene un increíble sistema de ramificación (branching) para desarrollo no lineal.
  #set align(center)
  #side-by-side[
    #link("https://git-scm.com/downloads")[Descargar]
  ][
  #link("https://git-scm.com/book/es/v2")[Pro Git - Libro Oficial en español]
]
]
#focus-slide[
  Interludio: la Consola
  #pause
  
  #text(size: 18pt)[
    (AKA "línea de comandos", "terminal", "shell" et cetera)
  ]
]

#new-section-slide("Manos a la obra")
#slide(title: `git --help`)[
  ```bash
gonzalo@ohana ldd % git --help
```
#pause
```bash
usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>] (...)

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone     Clone a repository into a new directory
   init      Create an empty Git repository or reinitialize an existing one

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
See 'git help git' for an overview of the system.
```
]
#slide(title: `git --version`)[
  ```bash
gonzalo@ohana ldd % git --version
```
#pause
```bash
git version 2.39.2 (Apple Git-143)
```
]
#slide(title: `git init`)[
```sh
gonzalo@ohana ldd % FRUTA=melon                  
gonzalo@ohana ldd % COLOR=purpura
gonzalo@ohana ldd % PROFESION=judoca
gonzalo@ohana ldd % mkdir $FRUTA-$COLOR-$PROFESION
gonzalo@ohana ldd % cd !!$
cd $FRUTA-$COLOR-$PROFESION
```
#pause
```sh
gonzalo@ohana melon-purpura-judoca % git init
Initialized empty Git repository in /Users/gonzalo/Git/ldd/melon-purpura-judoca/.git/
```
]

#slide(title: `git config`)[
```bash
--system: $(prefix)/etc/gitconfig  # nivel sistema, rara vez usado
--global: ~/.gitconfig  # nivel usuario, `~` es "la home" del usuario
--local: .git/config  # nivel repositorio, relativo a su raíz
```
#pause
```sh
git config --local user.name "Gonzalo Barrera Borla"
git config --local user.email gonzalobb@gmail.com
git config --global core.editor vim
```
#pause

Si están en su PC personal, pueden usar `--global`; 
#uncover("4-")[
#alert[si están en una computadora pública], con un usuario compartido -e.g.,  los labos-, #alert[usen `--local`.]
]]

#focus-slide([Interludio: La poesía])

#slide(title: "La Poesía")[
  
Abra su editor de texto favorito y complete con dos versos la siguiente copla:
#pause
```
Ayer pasé por tu aula
Me tiraste con un teorema
...
```
#pause
Guárdelo como `POEMA.txt` dentro del directorio del repo(sitorio).
]


#slide(title: `git status`)[
```sh
gonzalo@ohana melon-purpura-judoca % git status
```
#pause
```sh
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	POEMA.txt

nothing added to commit but untracked files present (use "git add" to track)
```
]

#slide(title: `git add POEMA.txt`)[
```sh
gonzalo@ohana melon-purpura-judoca % git add POEMA.txt
gonzalo@ohana melon-purpura-judoca % git status
```
#pause
```
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   POEMA.txt
```
]

#focus-slide()[
  Interludio: Más poesía
  
  #pause
  
  #set text(size: 20pt)
  Abra `POEMA.txt` con su editor de texto favorito.
  
  Agregue una segunda entrofa, de su propia invención, y guárdelo.
]


#slide(title: [`git status` (cont.)])[
```sh
gonzalo@ohana melon-purpura-judoca % vim POEMA.txt  # Aquí edité el archivo 
gonzalo@ohana melon-purpura-judoca % git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   POEMA.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   POEMA.txt
```
]
#slide(title: "git diff")[
```diff
gonzalo@ohana melon-purpura-judoca % git diff POEMA.txt 
diff --git a/POEMA.txt b/POEMA.txt
index e7316a6..7ff70d5 100644
--- a/POEMA.txt
+++ b/POEMA.txt
@@ -3,3 +3,8 @@ Me tiraste con un teorema
 La verdad, no había estudiado
 la demostración, qué pena!
 
+No es de vago, entiéndame
+es mi perro, el rengo Fefe
+que le encanta, yo lo sé
+devorar los pe de efe.
+
```
]

#slide(title: "Archivos en git: sus tres estados y el ciclo de vida")[
  #align(image("img/git-3-estados.png"), center)
]

#slide(title: "Archivos en git: su ciclo de vida")[
  #align(image("img/git-ciclo-vida-archivos.png"), center)
]

#slide(title: `git commit`)[
```sh
gonzalo@ohana melon-purpura-judoca % git commit -m "Primer estrofa"
```
#pause
```sh
[main (root-commit) 1ef4efe] Primer estrofa
 1 file changed, 5 insertions(+)
 create mode 100644 POEMA.txt
gonzalo@ohana melon-purpura-judoca % git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   POEMA.txt

no changes added to commit (use "git add" and/or "git commit -a")
```
]

#slide(title: `git commit`)[
```sh
gonzalo@ohana melon-purpura-judoca % git add POEMA.txt 
gonzalo@ohana melon-purpura-judoca % git commit -m "Segunda estrofa"
```
#pause
```sh
[main 2b625f9] Segunda estrofa
 1 file changed, 5 insertions(+)
gonzalo@ohana melon-purpura-judoca % git status
On branch main
nothing to commit, working tree clean
```
#pause
#alert[Lean siempre los mensajes de la terminal!]
]

#slide(title: `git log`)[
```sh
gonzalo@ohana melon-purpura-judoca % git log
```
#pause
```sh
commit 2b625f9c5823f1b43d583e7366a6dfce9803af57 (HEAD -> main)
Author: Gonzalo Barrera Borla <gonzalobb@gmail.com>
Date:   Tue Mar 26 07:20:59 2024 -0300

    Segunda estrofa

commit 1ef4efe798fc46699f3399c6065e0fbe7b13d664
Author: Gonzalo Barrera Borla <gonzalobb@gmail.com>
Date:   Tue Mar 26 07:20:39 2024 -0300

    Primer estrofa
```
]

#new-section-slide([Manos a la obra (ajena): los _remotos_])

#slide(title: "Trabajar con remotos")[
Para poder colaborar en cualquier proyecto Git, necesitas saber cómo gestionar
*repositorios remotos*. Los repositorios remotos son versiones de tu proyecto que están
*hospedadas en Internet* o en cualquier otra red. Puedes tener varios de ellos, y en cada
uno tendrás generalmente permisos de solo lectura o de lectura y escritura.

#pause

#alert[Un _servidor_ de `git` no es git], tanto como un _navegador web_ no es la web en sí: se puede usar cualquiera! El más popular es #link("https://github.com/")[Github], pero existen otros como 
#link("https://bitbucket.org/product")[Bitbucket] y #link("https://gitlab.com/users/sign_in")[Gitlab].
]

#slide(title: "Github Login")[
  #align(center, image("img/github-login.png"))
]

#slide(title: "Github - Nuevo Repositorio")[
  Nuestro repositorio sólo existe localmente por ahora. Démosle entidad en un _remoto_.
  #line-by-line[
  1. Botón verde "#link("https://github.com/capitantoto?tab=repositories")[+New]"
  2. Configuren:
    - Exacto mismo nombre que al repo local
    - Descripción breve
    - Sin `README.md`
    - Sin `.gitignore`
  3. Click a "Create Repository"]

]

#slide(title: "Github - Nuevo Repositorio (cont.)")[
=== …or push an existing repository from the command line

```sh
git remote add origin https://github.com/capitantoto/melon-purpura-judoca.git
git branch -M main
git push -u origin main
```
#pause
```bash
Username for 'https://github.com': capitantoto
Password for 'https://capitantoto@github.com': 
remote: Support for password authentication was removed on August 13, 2021.
remote: Please see https://docs.github.com/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
fatal: Authentication failed for 'https://github.com/capitantoto/melon-purpura-judoca.git/'
```
]

#slide(title: "Github Personal Access Token")[
  
  Los "Tokens de Acceso Personal" (PAT) son una alternativa al uso de contraseñas para la autenticación en GitHub cuando se usa la API de GitHub o la línea de comandos. El Personal access token está diseñado para acceder a los recursos de GitHub en tu nombre. 
  #pause
  
  Fuente: #link("https://docs.github.com/es/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens")[Administración de tokens de acceso personal]

  #pause
  #alert[Advertencia: Trate los tokens de acceso como si fueran contraseñas, y guárdelos en su administrador de contraseñas predilecto.]

  
  Desde el desplegable del "avatar", elijan "Settings" > "Developer Settings" > "Personal Access Tokens" > "Generate New Token"
]

#slide(title: "Github Personal Access Token (cont.)")[
  == "Generate New Token"
  #set align(top)
  #side-by-side[
    === ... si eligen "Fine-grained"
      - Scope ("envergadura"): *"All Repositories*" (podrán ser más estrictos luego)
      - Permisos "Read and Write" para
        - Contents
        - Issues
        - Pull Requests
  ][
    === ... si eligen "Classic"
    Tilden los permisos de "repo", que selecciona a toda la subsección correspondiente.
  ]
]

#slide(title: `git push`)[
```sh
gonzalo@ohana melon-purpura-judoca % git push -u origin main
Username for 'https://github.com': capitantoto
Password for 'https://capitantoto@github.com': 
```
#pause
```sh
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 8 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (6/6), 613 bytes | 613.00 KiB/s, done.
Total 6 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), done.
To https://github.com/capitantoto/melon-purpura-judoca.git
 * [new branch]      main -> main
branch 'main' set up to track 'origin/main'.
```
]

#focus-slide[
  Ahora, ingresen otra vez a 
  
  https://github.com/{usuario}/{repositorio}

  #pause
  Voilá!
]

#focus-slide()[
  Tarea para el hogar: #link("https://docs.github.com/es/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent")[Autenticación con clave SSH]
]

#slide(title: [Tenedores! ("forks")])[
  Una bifurcación ("fork") es un nuevo repositorio que comparte la configuración de visibilidad y código con el repositorio acendente ("upstream") original.
  
  #link("https://docs.github.com/es/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo?platform=linux&tool=webui#forking-a-repository")[Bifurcar un repositorio]
  #align(center, image("img/boton-fork.png", height: 50%))
]

#slide(title: "Ordenando el trabajo colaborativo")[
  #side-by-side[Pónganse en parejas. Pídanle a su _partenaire_ su nombre de usuario y repositorio, y _forkéenlo_ a su cuenta.
  
  #uncover("2-")[
    Abran el sitio web del _fork_, y busquen el botón verde [`<> Code`]
]
  #uncover("3-")[
  
  Elijan "HTTPS" (o "SSH" si ya lo saben usar) como método de clonado, y copien la URL visible justo debajo.]
  ][#uncover("2-")[#image("img/github-clone.png")]]
]

#slide(title: `git clone`)[
¿Y si en lugar de _crear_ un repositorio, queremos trabajar con uno ya existente?
#pause

```bash
gonzalo@ohana Git % git clone https://github.com/capitantoto/sandia-verde-maquinista.git
```
#pause
```bash
Cloning into 'sandia-verde-maquinista'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (3/3), done.
```
]

#slide(title: [Ramas! ("branches")])[
Una *rama* (_branch_) es "otra versión posible" del repositorio, que _diverge_ del tronco (u otroas ramas) en un cierto *_commit_*.

#pause
Cuando colaboramos, es de mala educación usar directamente
- ramas compartidas (`main, dev, etc.`),
- ramas "personales" (`un-feature-copado`, a cargo de Cosme Fulanito, que no soy yo)

#pause
```bash
gonzalo@ohana sandia-verde-maquinista % git branch                     
* main
gonzalo@ohana sandia-verde-maquinista % git branch modesta-mejora
gonzalo@ohana sandia-verde-maquinista % git checkout modesta-mejora 
Switched to branch 'modesta-mejora'
gonzalo@ohana sandia-verde-maquinista % git checkout -b inenarrable-mejora
Switched to a new branch 'inenarrable-mejora'
```
]
#slide(title: [Ramas! ("branches")])[
```bash
gonzalo@ohana sandia-verde-maquinista % git branch
* inenarrable-mejora
  main
  modesta-mejora
```
#pause
```bash
gonzalo@ohana sandia-verde-maquinista % git add POEMA.txt 

gonzalo@ohana sandia-verde-maquinista % git commit --message "Agrega tercera estrofa"
[inenarrable-mejora a75fcb5] Agrega tercera estrofa
 1 file changed, 5 insertions(+)
 
gonzalo@ohana sandia-verde-maquinista % git push origin inenarrable-mejora
```
]

#new-section-slide("Juntándolo todo: Pull Requests")
#slide(title: [Pedidos de tire (AKA: _pull requests_)])[
```bash
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 371 bytes | 371.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote: 
remote: Create a pull request for 'inenarrable-mejora' on GitHub by visiting:
remote:      https://github.com/capitantoto/sandia-verde-maquinista/pull/new/inenarrable-mejora
remote: 
To https://github.com/capitantoto/sandia-verde-maquinista.git
 * [new branch]      inenarrable-mejora -> inenarrable-mejora
```
]

#slide(title: [Pedidos de tire (AKA: _pull requests_)])[
  Vayan nuevamente a Github, y abran el repositorio que forkearon. Van a ver un aviso similar al siguiente:
  #pause
  #image("img/compare-and-pull-request.png")
  Cliqueen en "Compare & pull request" para "crear un PR". Exploren el sitio que se abre.
]

#slide(title: [Pedidos de tire (AKA: _pull requests_)])[
  A saber:
  #line-by-line[
    - Se puede comparar entre "mis repos" y "across forks" (a través de bifurcaciones). Aquí, elijan "across forks" para crear un PR contra el repo del colega como base.
    - Elijan `main` como rama contra la cual "mergear" su "rama tópica" (_feature branch_).
    - Como Revisor ("_Reviewer_"): elijan al dueño del repositorio original si es posible (deben ser "colaboradores" del repo original. Si no, dejen queel autor original del repo se auto-asigne más tarde.
    - Denle un título breve (si es que el automático no sirve), y en la descripción, justifiquen el por qué de los cambios propuestos.
    - Observen que el PR (Pull Request) se puede crear como borrador (_draft_).
    - #alert[Creenlo!]
  ]
]

#slide(title: "Revisiones de Código")[
    Vayan a su repositorio original, https://github.com/{usuario}/{repo}/pulls
    #pause
      
    ¿Ven el PR de su compañero que los tiene como revisor? Busquen la opción para comenzar la revisión si ya los asignaron. Si no, asigne como revisor a ud. mismo, y recargue la página; ahora debería ver el botón (verde) de "Start Review".
    #pause
    
    Ahora, pueden insertar comentarios en cualquier lugar del código, tantos como quieran, y hasta hacer directamente sugerencias de cambios a "commitear".
    #pause
    
    Finalmente, cierren la revisión con una evaluación global, y elijan uno de los tres estados: "Comment", "Approve", "Request Changes"
  
]

#slide(title: "Revisiones de Código")[
  #side-by-side[
    #image("img/pull-request-review-statuses.png")
  ][
    - "*Comentar*": Dar una devolución general sin una aprobación explícita.
    - "*Aprobar*": Dar una evolución y aprobar la fusión ("merging") de los cambios.
    - "*Requerir Cambios"*:  Proveer feedback que se debe incorporar al PR antes de _mergear_.
  ]
  
]

#slide(title: "Revisiones de Código, algunos tips")[
  #side-by-side[
    #line-by-line[
    === Para el revisor
      - #alert[La aprobación es solidaria]: no vale aprobar sin asumir la responsabilidad del cambio conjuntamente con el autor. 
      - Si hay problemas serios, eviten marcar nimiedades. Mejor _hablar personalmente_ para destrabar la situación.
      - GitHub también es una red social, seamos civilizados: _sean buena gente_.
      - Al pedir cambios que requerirán nuevas revisiones, #alert[no colgarla].
    ]
  ][
    #line-by-line(start: 6)[
    === Para el autor
      - Antes de pedir una revisión, #alert[abogado del diablo]: revisen ustedes mismos a fondo.
      - Sean corteses: usen la descripción del PR, o comentarios sobre el mismo, para dar contexto al revisor.
      - Expliquen "por qué" antes que "cmo": código bien escrito se documenta solo, pero los pensamientos son privados.
      - #alert[Tengan piel de rinoceronte]: están evaluando _su trabajo_, no su carácter.
    ]
  ]
]

#focus-slide("Gracias!")