Libreria-mapping-processing
===========================




 
Proyecto:
Programación de una librería para Processing que permita realizar mapping (glosario 1) en un número de superficies definidas por el usuario de cualquier topografía  2D  pudiendo visualizar archivos de video,  imagen y de animaciones algorítmicas calculadas en tiempo real con posibilidad de interacción con el mundo físico externo  a través de diferentes sensados. 
Una aclaración con respecto la topografía de la superficie de proyección, la misma puede ser 2D como 3D, en éste último caso podemos hablar que el objeto posee “caras” y queda a criterio del artista definir cada cara como una superficie de proyección 2D o configurar un conjunto de caras como una sola superficie 3D. En ambos casos la librería propuesta podrá realizar el mapeo en superficies que contengan líneas rectas y curvas.
	El proyecto consiste en:
	Programar el código de  la librería propuesta en JAVA lo cual es un requisito para que Processing pueda trabajar con ella (1).
	Confeccionar una página web donde los usuarios podrán:
1.	bajarse la librería compilada para instalarse en la forma habitual en processing 2.0.X.
2.	bajarse los archivos fuente de la misma.
3.	Accesar a la referencia en formato java doc en la cual estarán definidas las clases, las propiedades y los métodos de cada una como así también cada una de las instrucciones disponibles en processing a partir de la instalación de la librería, en la cual deberá constar su sintaxis, los parámetros y su tipología en los casos en que necesite recibirlos, el tipo de dato que devuelve en los casos pertinentes y una breve explicación de lo que la misma realiza.
4.	 Algunos ejemplos codificados en processing del uso de la librería.
	Realizar una obra utilizando la librería en processing utilizando visuales generadas algorítimicamente en tiempo real  e interactivas con el audio en vivo.
Avances experimentales:
	A pedido de la agrupación estudiantil “La Fuente” actual conducción del CEFI ( Centro de Estudiantes de la Facultad de Informática” realizé para el Festival FLISOL 2014 el 14 de junio del corriente año en el Hall central de la Facultad de Informática de la UNLP una obra de mapping con visuales generadas algorítmicamente  e interactivas con  el audio en vivo en tiempo real.
	Para dicha obra se construyó un objeto 3D que se utilizó como superficie de proyección y se realizó el software de mi autoría en processing que realizaba el mapeo y la generación de la visuales y el análisis de las señales de audio captadas por el micrófono incorporado de la notebook.
	Para el código en processing se empleó la librería keystone, http://keystonep5.sourceforge.net/ para obtener las superficies de proyección y la librería Ess   http://www.tree-axis.com/Ess/ para realizar el análisis  de la señal de audio capturada en vivo por el micrófono incorporado.

	En la experiencia logré:
	Instanciar un array de tipo GLGraphicsOffScreen y otro de tipo CornerPinSurface dimensionados por la variable  de tipo integer “cantidadsuperficies” cuyo valor puede ser redefindo por el usuario según sus necesidades, en mi caso para esta obra este valor se seteo en 15 porque ese era el número de superficies a mapear. En los experimentos preliminares he definido dicha variable en 33 y el software respondió muy bien sin observarse latencias o cuelgues.
Esta posibilidad de instanciar dichos array no está ejemplificada ni documentada en la página web correspondiente a la librería keystone y la instanciación de ambos array permitió disponer de una cantidad de superficies deseadas por el usuario en lugar de las tres que permite nativamente a librería keystone.

	Insertar en las superficies de proyección imágenes generadas algorítmicamente en tiempo real cuyos elementos visuales como ser: colores, transparencias, posición x,y en referencia a la superficie de proyección, tamaño, curvatura en determinados casos, cantidad de elementos a visualizar están definidos por la interacción de la señal de audio captada por el micrófono incorporado la cual se analiza por el algoritmo FFT que dispone la librería Ess utilizando los valores de las amplitudes instantáneas a 44.1 Khz de muestreo por 16 bits por muestra y a 30 frames por segundo.
El proceso de construcción e instalación de la obra y el funcionamiento de la misma en el marco de recital de las bandas en vivo en el festival FLISOL 2014 Facultad de Informática UNLP puede verse en: http://fugalozdan.wix.com/portfolio-flisol2014
En esta página se pueden observar videos de prototipos experimentales previos: http://flisol.lafuenteunlp.com.ar/#/festival
Otros videos sobre el proceso previo en youtube:
Primer prototipo de mapping y visual algorítmica interactiva: https://www.youtube.com/watch?v=K4YXAwnNDLI
Segundo prototipo: https://www.youtube.com/watch?v=-29YYkUOGxw

Proceso de mapeo de la instalación : https://www.youtube.com/watch?v=YNelAQ49deo

Porqué programar una librería para realizar mapping en Processing?
	En el trabajo anteriormente relatado experimenté con diferentes softwares tanto privativos como el resolume arena como las librerías de processing suffarcer-mapper y keystone, en todos los casos encontré algún tipo de restricción.
En el caso del resolume arena solo se permite visualizar archivos prediseñados ya sean videos o archivos de imágenes, no es posible generar algorítmicamente algún tipo de visualización u animación en tiempo real, si bien sobre los archivos el resolume puede realizar alguna interacción recibiendo data de otras herramientas vía oscP5 dichas interacciones se realizan sobre parámetros pre definidos por el software. También es necesario tener en cuenta que el mismo es privativo, no es de código abierto por lo que no es posible saber de qué manera realiza las tareas, no recibe contribuciones de una comunidad de interesados y obedece a una lógica de mercado privativo no siempre acorde con las necesidades expresivas del mundo artístico y no es gratuito.
En el caso de la librería Surface – mapper : http://www.ixagon.se/surfacemapper/ (última actualización 22 – 02 -2012) está en las versiones actuales de processing, 2.0 y superiores discontinuada y sin mantenimiento. No permite la generación de visuales algorítmicas en tiempo real si no que deben ser levantadas de algún tipo de archivo ya sea de video o de imagen pre diseñada.
En el caso de la librería keystone, finalmente seleccionada para la obra que presenté en el festival FLISOL 2014 la misma si permite visualizar animaciones algorítmicas en tiempo real pero por cada superficie ( off screen ) de proyección, la librería ofrece solo cuatro vértices deslizables con el mouse lo que impide el mapeo de superficies que contengan líneas curvas. También hay que tener en cuenta dos cuestiones que pueden ser una barrera para programadores no expertos e intermedios:
1.	No está documentada ni ejemplificada la posibilidad de visualizar animaciones algorítmicas en tiempo real.
2.	No esta documentada ni ejemplificada la posibilidad de instanciar un array de superficies de proyección con el cual disponer de un número de superficies definido por el programador usuario según su propia necesidad con lo que las mismas quedan limitadas a la cantidad de tres ofrecidas nativamente por la librería.
En resumen estas cuestiones que son el estado y situación actual en cuanto a este tema y mi propio interés personal es lo que me lleva a realizar la presente propuesta como trabajo de tesis final de maestría poniendo a la mano de aquellos artistas que incursionan en la intersección de los lenguajes artísticos y las tecnologías una herramienta open source, gratuita y flexible en la que les sea posible programar en processing su propio mapping sobre cualquier superficie topográfica y que puedan visualizarse animaciones algorítmicas en tiempo real, archivos de video y/o archivos de imágenes prediseñadas.
También hay que tener en cuenta que processing es el lenguaje de programación más usado por el conjunto de artistas contemporáneos que realizan obras que se inscriben en el empleo de las nuevas tecnologías, con lo que se aporta una herramienta accesible a una vasta comunidad  lo cual amerita su realización.



Bibliografía y webgrafía:
1.	https://github.com/processing/processing/wiki/Library-Guidelines
Glosario:
(1)	Mapping: “El video mapping es una técnica consistente en proyectar imágenes sobre superficies reales, generalmente inanimadas, para conseguir efectos de movimiento ó 3D dando lugar a un espectáculo artístico fuera de lo común.” http://www.baitic.com/innovacion/%C2%BF-que-es-el-video-mapping-sorprendete.html
Accesada el 20 – 07 – 2014
“En Arte, "Mapping", es una técnica que consiste en crear imágenes o videos que se proyectan sobre objetos tridimensionales, construcciones arquitectónicas, obras de ingeniería, y casi cualquier superficie, convirtiéndola en una pantalla de vídeo dinámica, con un acompañamiento sonoro (música o sonidos). Sirve como medio para permitir la exploración de las posibilidades que hoy en día se encuentran en el amplio escenario del arte contemporáneo y los medios electrónicos, como una de las funciones que pueden asumir las TIC en el ámbito del arte y la educación artística. Mapping es el resultado de la exploración de la tecnología para la manipulación y creación de imágenes, video y sonido; realizada por artistas. Los artistas contemporáneos usan el "mapping" como expresión vanguardista, un tipo de arte digital que mezcla videoarte, música y arte sonoro. Esta técnica modifica la apariencia propia del objeto tridimensional o espacio utilizado como pantalla o escenario para lograr los efectos deseados por el artista. El resultado es rico en sensaciones visuales y auditivas.
Brian y Michelle Dodson (2012), explican en su blog, http://videomapping.tumblr.com , que se utiliza un software especializado para deformar y ocultar la imagen proyectada, para que se ajuste perfectamente a las “pantallas/superficies de forma irregular”. Ellos agregan, que un mapping bien logrado tiene como “resultado final una instalación de proyección dinámica que trasciende una proyección de video común y corriente.”
http://es.wikipedia.org/wiki/Mapeado_normal accesada el 20 -07- 2014
“El videomapping es una tecnología de proyección utilizada para convertir objetos de formato irregular en una superficie de proyección. Utilizando un software especializado, un objeto de dos o tres dimensiones es espacialmente trazado en un entorno virtual. Empleando esta información, el software puede interactuar con un proyector para adaptar una determinada imagen o vídeo a la superficie de un objeto. Con esta técnica, los artistas pueden agregar dimensiones adicionales, ilusiones ópticas y sensaciones de movimiento a los objetos previamente estáticos. El vídeo es comúnmente combinado con audio para crear una narrativa audiovisual.

La práctica más habitual de las técnicas de videomapping es proyectar sobre edificios, aunque es posible realizar un videomapping sobre cualquier objeto o producto, coches, stands, cajas, etc.”
http://humantetrismapping.wordpress.com/2013/01/27/definicion-de-video-mapping/
accesada el 20 – 07 -2014























 

