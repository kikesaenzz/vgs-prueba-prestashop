# VGS · Prueba técnica PHP Developer — Prestashop (tema Falcon)

Maquetación de la **página de Categoría** y la **Ficha de producto** de Prestashop 8 sobre el tema para desarrolladores [Falcon](https://github.com/Oksydan/falcon) (Smarty + SCSS compilado con Webpack), siguiendo el diseño de Figma entregado.

Era mi primer contacto con Prestashop, así que además de las instrucciones de compilación documento las decisiones tomadas y las dificultades reales que me fui encontrando.

Este repositorio contiene **únicamente la carpeta del tema Falcon modificado**, tal y como pide el enunciado: no incluye el núcleo de Prestashop, ni `/vendor`, ni `/node_modules`, ni los assets compilados (se regeneran con `npm run build`).

## Instalación y compilación

1. Instancia limpia de **Prestashop 8.x** (no 9) instalada **con datos de demostración**, que son los productos sobre los que se ha maquetado.
2. Copiar este repositorio en `themes/falcon` y activar el tema en **Diseño → Tema y logotipo**.
3. Módulos que Falcon necesita (vienen en su release): `is_imageslider`, `is_searchbar`, `is_shoppingcart`, `is_themecore`.
4. Crear `_dev/webpack/.env` a partir de `_dev/webpack/.env-example`. **Es el paso que más problemas da** (ver dificultades):

   ```
   PORT=3000
   PUBLIC_PATH=/themes/falcon/assets/
   SERVER_ADDRESS=localhost
   SITE_URL=http://localhost
   ```

   `PUBLIC_PATH` debe apuntar a la ruta pública real del tema, **con la barra final**. Si la tienda no está en la raíz del dominio sino en un subdirectorio (por ejemplo `http://localhost/vgs-ps/`), hay que incluirlo:

   ```
   PUBLIC_PATH=/vgs-ps/themes/falcon/assets/
   ```

5. Compilar:

   ```bash
   cd _dev
   npm install
   npm run build     # producción
   npm run watch     # desarrollo, recompila al guardar
   ```

Durante el desarrollo conviene activar la recompilación de plantillas en **Parámetros avanzados → Rendimiento**, o Smarty seguirá sirviendo los `.tpl` cacheados.

## Alcance

Según el enunciado no se maqueta la Home. El trabajo se concentra en:

- **Página de Categoría**: cabecera de categoría, listado, tarjeta de producto, columna de categorías/filtros y paginación.
- **Ficha de producto**: galería, bloque de compra, características y descripción.

Cabecera y pie se han maquetado también porque son visibles en ambas pantallas del diseño.

## Estructura del trabajo

Los estilos propios viven en ficheros separados y se importan al final de cada bundle, de modo que ganan por orden de cascada **sin necesidad de `!important`**:

```
_dev/css/
├── abstracts/variables/bootstrap/
│   ├── _colors.scss        → paleta del diseño (teal, morado, amarillo…)
│   ├── _grid.scss          → contenedor a 1330px (los 1310px de contenido del diseño)
│   └── _typography.scss    → Montserrat como tipografía base
├── theme/vgs/
│   ├── _header.scss        → barra superior, buscador, menú y migas
│   └── _footer.scss        → pie
├── listing/_vgs-brand.scss → categoría: banda de título, filtros, rejilla, tarjeta y paginación
└── product/_vgs-brand.scss → ficha: galería, precios, compra, características y descripción
```

Cabecera y pie van en el bundle global (`theme.scss`) porque se ven en todas las páginas; categoría y ficha van en los suyos (`listing.scss` y `product.scss`) para no cargar en cada página estilos que no usa.

Plantillas tocadas:

```
templates/_partials/header.tpl                     barra superior, migas y banda de categoría
templates/_partials/footer.tpl                     bloque de contacto y copyright
templates/_partials/pagination.tpl                 paginación con recuento
templates/layouts/layout-left-column.tpl           caja única de categorías + filtros
templates/catalog/product.tpl                      orden del diseño en la ficha
templates/catalog/_partials/product-prices.tpl     precio, precio anterior y descuento en línea
templates/catalog/_partials/product-tabs.tpl       la descripción sale de las pestañas
templates/catalog/_partials/category-header.tpl    el título pasa a la banda de la cabecera
templates/catalog/_partials/miniatures/product.tpl tarjeta del listado
templates/catalog/_partials/miniatures/_partials/product-prices.tpl
                                                   orden de precios de la tarjeta
templates/catalog/_partials/miniatures/_partials/product-title.tpl
templates/catalog/_partials/product-flags.tpl      etiquetas de estado
templates/catalog/_partials/product-add-to-cart.tpl fila de compra del diseño
modules/ps_mainmenu/ps_mainmenu.tpl                icono de menú de la barra
modules/ps_facetedsearch/views/templates/front/catalog/facets.tpl
modules/ps_customersignin/ps_customersignin.tpl    icono de cuenta a línea
modules/ps_customeraccountlinks/ps_customeraccountlinks.tpl
modules/is_searchbar/views/templates/hook/is_searchbar.tpl
modules/is_shoppingcart/views/templates/hook/is_shoppingcart.tpl
modules/is_shoppingcart/views/templates/front/modal-success.tpl
templates/index.tpl                                 la portada redirige a Cosmética
```

Un archivo de JavaScript propio del tema también se tocó:
`_dev/js/listing/components/filters/FiltersUrlHandler.js`, que construye la
URL del filtro de precio (ver dificultad 22).

Los seis overrides de módulo (Falcon ya traía el mecanismo: basta con
reproducir la ruta del módulo dentro de `themes/falcon` para que gane a la
plantilla original) viven dentro de la carpeta del tema y viajan con este
repositorio.

## Decisiones técnicas

- **La paleta y la tipografía se declaran como variables de Bootstrap**, no como literales repartidos por el SCSS. Los colores del diseño (`#328189`, `#592BC7`, `#BAE4EB`…) están en `_colors.scss` y de ahí beben botones, precios, badges y bandas: un único punto de cambio.
- **Montserrat se sirve desde el propio tema**, igual que Falcon hace con Roboto, en vez de enlazar Google Fonts. Es una fuente variable, así que un único fichero por subset cubre los pesos 400–700 (unos 38 KB el subset latin).
- **La rejilla de productos pasa de `row`/`col` a CSS grid.** Iguala el alto de las tarjetas de cada fila sin JS y expresa mejor las tres columnas del diseño.
- **Las migas y el nombre de la categoría son bandas a ancho completo** en el diseño, pero el layout de Falcon las pinta dentro del `.container`. Se han movido a `_partials/header.tpl`, que es el único punto fuera de ese contenedor, manteniendo el marcado semántico (`<nav>` + `<ol class="breadcrumb">`).
- **Categorías y filtros comparten una única caja** con borde teal, como en el diseño, envolviendo el contenido de la columna y retirando el marco de las `.card` que pintan los módulos.
- **La descripción larga sale de las pestañas** a un bloque "Información del producto" a ancho completo. Los detalles, adjuntos y contenido extra siguen accesibles en las pestañas.
- **La tarjeta del listado no lleva botón de carrito ni vista rápida**, porque el diseño solo muestra imagen, título y precio.
- **No se ha tocado la lógica de negocio.** Añadir al carrito y el refresco de precio/imagen al cambiar de combinación son los nativos de PrestaShop y Falcon; el trabajo se ha limitado a `.tpl` y SCSS.
- **Los valores salen de la API de Figma, no de medir sobre la captura.** Recorriendo el árbol de nodos se obtienen las medidas y los colores exactos: la tarjeta es de 312×416 con la franja de información en 104, la galería de la ficha 534×533, las bandas de la cabecera de 29, 38 y 41 px. Un detalle que solo se ve así: los marcos no son el teal plano sino `#328189` al 30 %.
- **Entre las migas y el título hay una banda de imagen a ancho completo** (206 px) con la portada de la categoría. Solo se pinta si la categoría tiene imagen.
- **En la ficha no hay etiquetas sobre la imagen**: el descuento se comunica con la píldora junto al precio, así que repetirlo encima de la foto sobraba.
- **Dos bloques de módulo se ocultan desde el tema** porque el diseño no los recoge y duplicaban información: el "Información de la tienda" de `ps_contactinfo` (repetía la columna de contacto del pie) y el de compartir en redes de la ficha. Se ocultan con una regla, no desactivando el módulo, que es configuración de la tienda: basta con retirarla para recuperarlos.
- **La portada redirige a Cosmética.** El enunciado no pide maquetar la Home, y el contenido de demostración de Falcon ("20% OFF ON CLOTHES", bloques de texto de relleno) dejó de tener sentido en cuanto el catálogo pasó a ser solo cosmética. En vez de dejar esa página inconsistente a la vista, `index.tpl` redirige por JavaScript a la categoría real de la tienda, con un enlace visible como respaldo si JavaScript está deshabilitado.
- **La columna de filtros solo ofrece las dos facetas del diseño**, "Categorías" y "Precio". `ps_facetedsearch` puede filtrar también por disponibilidad y por cualquier característica del catálogo (Tipo de piel, Función…), pero el Figma no las muestra, así que se han dejado desactivadas en la plantilla de filtros en vez de activar todo lo que el módulo permite.
- **Los iconos de cuenta y carrito se dibujan con la geometría del Figma.** El diseño los pinta a línea, y Material Icons —que es lo que trae Falcon— solo tiene la versión rellena. Se exportan del Figma y se insertan como SVG en línea, heredando el color con `currentColor`.
- **Los textos que salían en inglés se corrigen sobrescribiendo la plantilla del módulo, no traduciendo en el back office.** El buscador, el modal del carrito y el título "Mi cuenta" del pie pertenecen a módulos sin catálogo en español. Cambiar la cadena de origen en el override deja el arreglo dentro del repositorio; una traducción del back office se quedaría en la base de datos.
- **Los titulares del pie van en blanco.** El Figma los marca en `#c2e3ea`, pero sobre el teal del pie se leen con poco contraste, así que se ha preferido el blanco.
- **El porcentaje de descuento se escribe sin decimales**, como en el diseño: PrestaShop lo calcula a partir de los dos precios y devuelve, por ejemplo, `-11,13%`.
- **El icono de menú de la barra es decorativo.** En el diseño acompaña a "CATEGORÍAS"; en escritorio los dos enlaces ya están a la vista, así que se marca `aria-hidden` en lugar de dejar un control que no lleva a ninguna parte.
- **La cabecera no lleva logotipo**, tal y como marca el diseño: se ha retirado el bloque del logo de Falcon en vez de ocultarlo por CSS, para no dejar HTML muerto. Sin ese bloque, el buscador y los iconos de cuenta/carrito se agrupan contra el borde derecho de la cabecera con `margin-left: auto`, dejando el hueco en blanco de la izquierda que tiene el Figma.
- **El menú superior solo muestra "Categorías" y "Promociones"**, los dos textos literales del diseño, en vez del árbol de categorías que pinta `ps_mainmenu` por defecto. "Categorías" enlaza a la categoría real que trae el menú configurado (Cosmética) y "Promociones" al listado de ofertas nativo de PrestaShop (`controller=prices-drop`); ninguno de los dos enlaces está escrito a mano, así que si el día de mañana cambia el identificador de la categoría, el enlace se sigue generando solo. El mismo `<ul>` alimenta también el menú de móvil, que Falcon rellena clonando por JS el menú de escritorio.
- **El bloque de suscripción a la newsletter no está en el diseño**, así que se ha retirado el hook (`displayFooterBefore`, del módulo `ps_emailsubscription`) directamente de `footer.tpl` en vez de desactivar el módulo, que es configuración de la tienda.
- **En la banda de marca/referencia y en el primer párrafo de la descripción, el diseño mezcla dos pesos y colores en el mismo texto**: la etiqueta ("MARCA:") va en mayúsculas, negrita y teal, y el valor que la sigue en gris normal; el primer párrafo de la descripción va entero en negrita y el resto del cuerpo en peso normal. Se resuelve con CSS (`.vgs-product-meta__label` para lo primero, `.product-description > p:first-child` para lo segundo) en vez de negrita a mano en el HTML, para que siga funcionando si cambia el contenido.

## Dificultades encontradas

Vengo de WordPress, así que anoto lo que costó de verdad.

**1. La versión de PHP importa mucho más que en WordPress.**
Prestashop 8.x no arranca con PHP 8.4/8.5 (la versión por defecto de mi máquina). Hubo que usar PHP 8.1 específicamente para esta prueba.

**2. El paquete de descarga viene doblemente comprimido.**
El zip de la release contiene otro `prestashop.zip` dentro, y el `index.php` del zip exterior es solo un instalador, no el front controller real. Si se descomprime todo junto sin fijarse, la tienda se queda "pillada" en la pantalla de instalación aunque ya esté instalada.

**3. openssl en PHP para Windows.**
El instalador fallaba en `openssl_pkey_get_details()` al generar `parameters.php`. Se resolvió apuntando la variable de entorno `OPENSSL_CONF` al `openssl.cnf` que trae el propio PHP.

**4. Los iconos se veían como texto (`search`, `person`, `shopping_basket`).**
Parecía un problema de fuentes, pero el origen estaba en el build: Webpack escribe las URLs de fuentes e imágenes usando `PUBLIC_PATH`, que por defecto es `/themes/falcon/assets/`. Con la tienda en un subdirectorio esa ruta absoluta devolvía **403** y Material Icons no cargaba, mostrando el nombre del icono. Se arregla ajustando `PUBLIC_PATH`. Ojo también con la **barra final**: sin ella, Prestashop concatena la ruta a pelo y genera URLs como `.../assetsjs/archivo.js`.

**5. Especificidad frente a `!important`.**
Al sustituir el `row`/`col` por CSS grid, las tarjetas seguían saliendo al 33 % de ancho. La causa era `.layout-left-column .products-list__block--grid` (dos clases) ganando a mi regla de una sola clase: no era orden de carga sino especificidad. Repetir el ancestro en mi selector lo resuelve manteniendo la regla del enunciado de evitar `!important`.

**6. Smarty cachea las plantillas.**
Editar un `.tpl` no se reflejaba hasta vaciar `var/cache`. Activando la recompilación de plantillas en Rendimiento el ciclo de trabajo se vuelve normal. Viniendo de WordPress, donde tocar un `.php` es inmediato, no era obvio.

**7. Saber qué plantilla toca.**
Falcon reparte el marcado en muchos parciales (`_partials/miniatures/…`, `catalog/_partials/…`). Localizar el fichero correcto es cuestión de seguir la cadena de `{include}` desde el layout, ayudándose del HTML generado.

**8. Respetar el refresco AJAX de las combinaciones.**
Al cambiar de talla o color, PrestaShop vuelve a renderizar parte de la ficha. Todo lo que se añada dentro de ese bloque debe estar en las plantillas que se re-renderizan, o desaparece tras el primer cambio. Se comprobó cambiando de combinación y verificando que la banda de marca/referencia seguía maquetada y que imagen y precio se actualizaban.

**9. Una banda a ancho completo dentro del contenedor.**
La barra del menú llega a los bordes del navegador en el diseño, pero el módulo la pinta dentro del `.container`. Se estira con un pseudo-elemento de `100vw` centrado y se recorta el sobrante de la barra de desplazamiento con `overflow-x: clip` en la cabecera. `clip` y no `hidden`: `hidden` obligaría al eje vertical a `auto` y cortaría los submenús que caen hacia abajo.

**10. Acertar con la clase que usa el tema.**
Mis estilos del menú apuntaban a `.main-menu__list`, que en Falcon solo existe en los submenús; el listado de primer nivel es `.main-menu__dropdown`. Lo mismo con las etiquetas de estado: `.product-flags__flag`, no `.product-flag`. Escribir el selector "razonable" en vez de leer el HTML generado cuesta un rato de estilos que no se aplican y no dan ningún error.

**11. Las utilidades de Bootstrap llevan `!important`.**
La tarjeta salía 40 px más alta de la cuenta por un `mb-2` en el título y el margen que Falcon da al bloque de precios. Como las utilidades de espaciado de Bootstrap son `!important`, no hay especificidad que valga: hay que quitar la clase de la plantilla. Igual con `.rounded`, que pisaba el radio de 8 px de las etiquetas.

**12. Centrar en el contenedor equivocado rompe el carrusel.**
La galería de la ficha mostraba la segunda imagen en lugar de la portada. No era el carrusel: yo había puesto `justify-content: center` en `.product-main-images__list`, que resulta ser el `swiper-wrapper`. Sus tres diapositivas juntas son más anchas que la caja, así que el navegador centraba el conjunto y dejaba a la vista la del medio. Con una sola imagen —los productos de demostración— el fallo no se notaba. El centrado va en cada `.swiper-slide`.

**13. Un archivo transparente convertido a JPG deja de serlo.**
El pictograma de la banda de categoría salía con un cuadrado blanco detrás en vez de fondo transparente. El script que generaba la miniatura aplanaba el PNG sobre blanco antes de guardarlo como JPG (JPG no tiene canal alfa), heredado del mismo aplanado que sí hace falta para las fotos de producto. El pictograma se guarda como PNG, sin aplanar.

**14. `$category.image.large.url` no es el tamaño real que sugiere el nombre.**
La banda de imagen de la categoría se veía pixelada: la instalación no tiene registrado un tipo de imagen "large" para categorías (solo `small_default` a 98×98 y `category_default` a 141×180), así que ese campo caía en la miniatura de 141px estirada a 788px de ancho por CSS. Se genera un archivo aparte a un tamaño real (1330px) y se referencia directamente por nombre de archivo en vez de depender del tipo de imagen.

**15. Borrar productos y categorías no reindexa los filtros.**
Al vaciar el catálogo de ropa y crear el de cosmética, la columna de filtros se quedó vacía: la plantilla de filtros de `ps_facetedsearch` seguía apuntando a las categorías antiguas (Inicio, Men, Women…) y ninguna de las características nuevas (Tipo de piel, Función…) estaba marcada como filtrable en `layered_indexable_feature`. Hay que reescribir la plantilla de filtros (tabla `layered_filter`, un blob serializado de PHP) apuntando a las categorías y características vigentes, y volver a llamar a `buildLayeredCategories()`, `indexFeatures()` e `indexAttributeGroup()` del propio módulo. El admin lo hace con un botón; sin acceso al admin (o para que quede repetible en un script), hay que llamar a esos mismos métodos.

**16. Una clase de más en el `<input>` rompía el selector de cantidad.**
El botón "+" de la cantidad no aparecía pegado al de "−": los dos quedaban superpuestos en el mismo sitio. La plantilla ponía `class="input-group input-touchspin"` en el `<input>` original, pero el plugin TouchSpin envuelve ese `<input>` en un **nuevo** `<div class="input-group bootstrap-touchspin">` con los botones dentro. Mi CSS apuntaba a `.input-group`, así que se aplicaba tanto al `<input>` suelto (antes de que el JS lo envolviera) como al div nuevo, y las dos cajas de 128px superpuestas descolocaban los botones. Se quita la clase sobrante del `<input>` y el CSS pasa a apuntar a `.bootstrap-touchspin`, la clase que el plugin garantiza en el envoltorio real.

**17. Un `::before` a `100vw` solo funciona si el elemento está perfectamente centrado.**
El filete blanco del pie no llegaba a los bordes reales del navegador aunque el CSS calculaba `left: calc(-50vw + 50%)` (la variante de `100vw` que evita el desbordamiento por la barra de desplazamiento, que ya me había hecho falta para la banda del menú). Ese cálculo asume que el elemento que lo genera está centrado en el viewport, y `.vgs-footer-bottom` no lo estaba: vivía dentro de `.container` sin pasar por un `.row` de Bootstrap, así que no tenía los márgenes negativos que compensan el padding del `.container` y quedaba 10px descentrado. En la banda del menú sí funcionaba porque ese bloque es un `.col-12` real dentro de un `.row`, que sí trae esa compensación. La solución robusta no fue ajustar el cálculo, sino sacar el filete del `.container` por completo: vive suelto dentro de `.footer-container` (que sí ocupa el 100% real, sin padding) y envuelve su propio `.container` para el texto, sin ningún truco de `vw`.

**18. El color de un texto puede no ser el que devuelve la API a la primera.**
"Marca:", "Referencia:" y "Disponibilidad:" salían en gris cuando el diseño los marca en teal y en mayúsculas. La consulta rápida a la API (`fills[0].color`) sí traía gris — pero es el color del **primer carácter**, no de todo el texto: es un nodo de texto enriquecido, con un `characterStyleOverrides` que aplica teal y mayúsculas solo a la etiqueta ("MARCA:") y dejaba el valor (" Caudelie") en gris normal. Los nodos de texto con estilos mixtos hay que leerlos con `styleOverrideTable`, no solo con el color base. Lo mismo pasaba con el primer párrafo de "Información del producto", en negrita en el diseño mientras el resto del cuerpo va en peso normal.

**19. El asset de una banda de imagen puede no ser una foto, sino una captura de referencia.**
La banda de imagen de la categoría se veía irreconocible (recortada por el medio de una imagen mucho más alta de lo necesario). El export de Figma para ese nodo ("header print screen") no es una foto de producto: es una captura de pantalla completa de un sitio de referencia real que el diseñador usó como maqueta, con la barra de Chrome, el escritorio y el dock incluidos. La franja que interesa —las estanterías con los productos— hay que recortarla a mano dentro de esa captura; dejar que `object-fit: cover` decidiera el recorte automáticamente, centrado en una imagen mucho más alta que ancha, cortaba justo la parte con contenido.

**20. Un valor de atributo HTML y una cadena de JavaScript no se escapan igual.**
El redirect de la portada apuntaba a una URL con `&amp;` literal en vez de `&`, así que el navegador la interpretaba mal. `Link::getCategoryLink()` da por hecho que su resultado va a un atributo `href` y ya viene sin tocar (con `&` normal), pero el auto-escapado HTML de Smarty (activo por defecto en cualquier `{$variable}`, con o sin modifiers explícitos de por medio) se aplica **después** de mis propios modifiers si no se cierra la cadena con `nofilter`, así que el `&` se convertía en `&amp;` de todas formas al final del pipeline. Para insertar una URL dentro de un `<script>` hacen falta dos cosas: decodificar cualquier entidad HTML que ya traiga (`unescape:'html'`) y terminar con `nofilter` para que el auto-escape de Smarty no vuelva a tocarla después de haberla escapado ya para JavaScript.

**21. Activar todo lo que un módulo permite no es lo mismo que seguir el diseño.**
Los filtros no solo estaban vacíos: cuando empezaron a funcionar, mostraban siete facetas (disponibilidad, precio, categorías y las cuatro características del catálogo) porque activé todas las que el catálogo nuevo hacía posibles. El Figma solo muestra dos, "Categorías" y "Precio". Que un dato exista y sea filtrable no significa que el diseño lo pida.

**22. El filtro de precio se quedaba cargando sin fin.**
Marcar el rango de precio dejaba la página "pensando" para siempre. El slider de precio no usa los enlaces que genera PHP como los checkboxes (`data-search-url`, ya con `id_category` y `controller` incluidos): construye la URL él mismo en JavaScript, a partir de `window.location.origin + window.location.pathname`. Sin URLs amigables —como en esta tienda—, el *pathname* es solo `/index.php`; `id_category` y `controller` viajan en la *query string*, así que la petición AJAX del slider los perdía por completo y acababa pidiendo la portada. Con la portada ahora redirigiendo a la categoría (ver "Decisiones técnicas"), la petición nunca encontraba el bloque de productos que esperaba recibir de vuelta, y el listado se quedaba en el estado de "cargando" para siempre. Se corrige en `FiltersUrlHandler.js` (JS propio de Falcon, no del módulo de filtros) conservando el resto de la *query string* actual al construir la URL, tal y como ya hacen los enlaces de los checkboxes.

**23. Solo la mitad de la cabecera era "sticky", y el elemento pegajoso rehecho a medias rompe la plantilla.**
Al hacer scroll, la franja amarilla desaparecía mientras el buscador y el menú se quedaban fijos arriba: quedaban dos comportamientos distintos dentro de lo que en el diseño es una sola pieza. La franja amarilla (`header_nav`) y la barra de búsqueda/menú (`header_top`) son dos `{block}` de Smarty distintos, pero el JS que fija el header (`useStickyElement.js`, de Falcon) solo envolvía el segundo (`.js-header-top-wrapper` rodeaba únicamente `header_top`). La solución es mover ese envoltorio para que abarque ambos bloques — pero `header_top` en Falcon no se cierra donde parece: sigue abierto mucho más abajo, envolviendo también las migas y el título de categoría como sub-bloques anidados, y cierra al final del archivo. Cerrar `header_top` justo después de mi cambio (donde "debería" terminar a simple vista) dejaba un `{/block}` huérfano 80 líneas más abajo y tumbaba las dos páginas con un 500. La regla: los `<div>` de HTML se pueden abrir y cerrar donde convenga sin mirar los `{block}` de Smarty, pero los `{block}` en sí solo se pueden cerrar donde de verdad terminan — hay que leer el archivo entero, no solo la sección que se está tocando.

**Analogía que ayudó**: los `{hook}` de Smarty son conceptualmente como los `do_action`/`apply_filters` de WordPress, y sobrescribir un `.tpl` equivale a un *template override* de un child theme. Con esa asociación mental, moverse por las plantillas fue mucho más intuitivo.

## Comprobaciones realizadas

- Portada (`index.php`) redirigiendo a Cosmética.
- Navegación por categorías con los productos reales de cosmética, los dos filtros del diseño (categorías y precio) y paginación: se ha comprobado que marcar un filtro cambia el listado sin recargar y que entrar en cada subcategoría muestra solo sus productos.
- Ficha de producto: la cantidad se puede subir y bajar con los botones "−"/"+", cambio de combinación actualizando imagen y precio, y **añadir al carrito** abriendo el modal con producto y subtotal correctos.
- Responsive verificado a 375 px y en escritorio, sin desbordamiento horizontal en categoría, ficha, portada ni pie.
- `npm run build` sin errores y sin errores en la consola del navegador en categoría, ficha y portada.
- Medidas contrastadas contra los nodos de Figma: contenedor 1330, columna de filtros 313, tarjeta 312×416 con franja de 104, galería 534×533, bandas de cabecera de 29/38/41 px y paginación de 40×40.
- Sin `!important` en el SCSS propio.

## Lo que depende de los datos de la tienda, no del tema

El tema es lo único que viaja en este repositorio. Para que las capturas y el
vídeo se parezcan al diseño, la tienda local se ha poblado con el catálogo del
Figma, que **no** forma parte del tema:

- **Categoría "Cosmética"** con las subcategorías del diseño (Capilar, Corporal, Facial, Ojos, Labios, Manos, Fragancias), su foto de portada —que alimenta la banda a ancho completo— y el pictograma de la banda del título.
- **Los productos del diseño** con sus nombres, precios, características y estados (uno fuera de stock, dos marcados como novedad). Las imágenes se han exportado del propio Figma y se guardan aplanadas sobre blanco, que es el fondo que usa el diseño.
- **Las columnas del pie** (INFORMACIÓN, LEGAL) son bloques de `ps_linklist`, y "Mi cuenta" los pinta `ps_customeraccountlinks`. Se configuran en **Módulos → Enlaces del pie de página**.
- **El catálogo de ropa de las demostración se ha borrado**, no solo ocultado: los productos y las categorías Clothes, Accesorios y Art (con sus subcategorías) no existen en esta base de datos. El diseño solo cubre cosmética, y dejar el resto del catálogo visible en el buscador, en "Promociones" o en el propio menú habría contradicho el punto 3 de "solo debe aparecer lo que hay en el Figma". El script que lo hace, `vgs-limpiar-catalogo.php`, vive junto a los demás en `datos-tienda/` y no es reversible por sí solo: antes de ejecutarlo se vuelca la base de datos completa a `datos-tienda/backups/`.
- **Los filtros de la columna izquierda se reindexan aparte** (`vgs-reindexar-filtros.php`), porque borrar y crear catálogo no actualiza por sí solo la plantilla de facetas de `ps_facetedsearch`. La plantilla de filtros solo activa las dos facetas del diseño (categorías y precio); sin este paso la columna de "Filtros" queda vacía o, si se activa todo lo que el módulo permite, muestra más de lo que hay en el Figma.
- **El pictograma de la banda de categoría** (transparente) y **la banda de imagen a ancho completo** los genera `vgs-icono-transparente.php` y `vgs-banner-categoria.php`, aparte del resto de imágenes de `vgs-imagenes-categoria.php`. La banda no es un simple redimensionado: el asset de Figma para esa zona es la captura completa de un sitio de referencia (barra de navegador y escritorio incluidos), así que el script recorta a mano la franja de estanterías con los productos antes de ajustarla al tamaño real de la banda (1330×206).

Sobre una instalación limpia con los datos de demostración de PrestaShop, el
tema se ve igual en las páginas de categoría y ficha; el catálogo de ropa que
trae de serie seguirá ahí hasta que se ejecute `vgs-limpiar-catalogo.php`, y
el menú superior solo enlazará correctamente si antes existe la categoría
Cosmética (la crea `vgs-catalogo.php`).

### Un desajuste del propio diseño

En la ficha, el Figma pone **23,95 €** como precio actual, **26,95 €** como
precio anterior y una píldora de **-30 %**. Esos tres números no cuadran entre
sí: de 26,95 a 23,95 hay un 11 %. Se han respetado los dos precios, que son lo
que más se lee, y el porcentaje lo calcula PrestaShop a partir de ellos.
