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
```

## Decisiones técnicas

- **La paleta y la tipografía se declaran como variables de Bootstrap**, no como literales repartidos por el SCSS. Los colores del diseño (`#328189`, `#592BC7`, `#BAE4EB`…) están en `_colors.scss` y de ahí beben botones, precios, badges y bandas: un único punto de cambio.
- **Montserrat se sirve desde el propio tema**, igual que Falcon hace con Roboto, en vez de enlazar Google Fonts. Es una fuente variable, así que un único fichero por subset cubre los pesos 400–700 (unos 38 KB el subset latin).
- **La rejilla de productos pasa de `row`/`col` a CSS grid.** Iguala el alto de las tarjetas de cada fila sin JS y expresa mejor las tres columnas del diseño.
- **Las migas y el nombre de la categoría son bandas a ancho completo** en el diseño, pero el layout de Falcon las pinta dentro del `.container`. Se han movido a `_partials/header.tpl`, que es el único punto fuera de ese contenedor, manteniendo el marcado semántico (`<nav>` + `<ol class="breadcrumb">`).
- **Categorías y filtros comparten una única caja** con borde teal, como en el diseño, envolviendo el contenido de la columna y retirando el marco de las `.card` que pintan los módulos.
- **La descripción larga sale de las pestañas** a un bloque "Información del producto" a ancho completo. Los detalles, adjuntos y contenido extra siguen accesibles en las pestañas.
- **La tarjeta del listado no lleva botón de carrito ni vista rápida**, porque el diseño solo muestra imagen, título y precio.
- **No se ha tocado la lógica de negocio.** Añadir al carrito y el refresco de precio/imagen al cambiar de combinación son los nativos de PrestaShop y Falcon; el trabajo se ha limitado a `.tpl` y SCSS.

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

**Analogía que ayudó**: los `{hook}` de Smarty son conceptualmente como los `do_action`/`apply_filters` de WordPress, y sobrescribir un `.tpl` equivale a un *template override* de un child theme. Con esa asociación mental, moverse por las plantillas fue mucho más intuitivo.

## Comprobaciones realizadas

- Navegación por categorías con los productos de demostración, filtros y paginación.
- Ficha de producto: cambio de combinación (talla y color) actualizando imagen y precio, y **añadir al carrito** abriendo el modal con producto y subtotal correctos.
- Responsive verificado a 375 px y en escritorio, sin desbordamiento horizontal.
- `npm run build` sin errores.
