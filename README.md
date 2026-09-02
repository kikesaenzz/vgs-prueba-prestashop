# VGS · Prueba técnica PHP Developer — Prestashop (tema Falcon)

Maquetación de la página de Categoría y la Ficha de producto de Prestashop 8.2.3 sobre el tema para desarrolladores [Falcon](https://github.com/Oksydan/falcon) (Smarty + SCSS/Webpack), siguiendo el diseño de Figma entregado. Es la primera vez que trabajo con Prestashop, así que este README explica también las decisiones y las dificultades que me he encontrado viniendo de WordPress.

Este repositorio contiene **únicamente la carpeta del tema Falcon modificado** (tal y como pide el enunciado); no incluye el núcleo de Prestashop, `/vendor` ni `/node_modules`.

## Instalación / compilación

1. Instancia de Prestashop **8.2.3** (no 8.9) con este tema copiado en `themes/falcon` y activado desde **Diseño > Tema y logotipo**.
2. Módulos requeridos por Falcon (versión release, no el código fuente): `is_imageslider`, `is_searchbar`, `is_shoppingcart`, `is_themecore`, instalados en `modules/` de Prestashop.
3. Compilar los assets:
   ```bash
   cd _dev
   npm install
   npm run build     # build de producción
   npm run watch     # o en watch mode mientras se desarrolla
   ```
   Antes del build hace falta un `_dev/webpack/.env` (no versionado) con al menos:
   ```
   PORT=3000
   PUBLIC_PATH=/themes/falcon/assets/
   SERVER_ADDRESS=tu-dominio.local
   SITE_URL=http://tu-dominio.local
   ```

## Qué se ha maquetado

- **Página de Categoría** (`templates/catalog/listing/_partials/category-header.tpl` + `_dev/css/listing/_vgs-brand.scss`): banda de cabecera de categoría a color, chips de "filtros activos" y tarjetas de producto (`_partials/miniatures/product.tpl`) con esquinas redondeadas y efecto hover, reutilizando las variables de Bootstrap del propio tema en vez de reescribir el HTML.
- **Ficha de producto**: se ha mantenido la plantilla nativa de Falcon (galería a un lado, información + "Add to cart" al otro, ya viene así de fábrica) y solo se ha retocado el color de marca; **no se ha tocado la lógica JS de combinaciones** (`product.js` de Falcon), que sigue gestionando el cambio de precio/imagen al elegir talla/color.
- **Color de marca**: `$primary` en `_dev/css/abstracts/variables/bootstrap/_colors.scss`, de donde beben tanto los botones (`.btn-primary`, "Añadir al carrito") como los precios y la cabecera de categoría — un único punto de cambio en vez de colores sueltos repetidos.
- Sin `!important` en ninguna regla añadida: los overrides de marca (`vgs-brand.scss`, tanto en `theme/` como en `listing/`) se importan **al final** de cada bundle de Sass para ganar por orden de cascada, no por especificidad forzada.

## Dificultades encontradas (siendo nuevo en Prestashop)

- **La versión de PHP importa mucho más que en WordPress.** PrestaShop 8.x no arranca con PHP 8.4/8.5 (la versión por defecto de mi máquina); tuve que instalar/usar PHP 8.1 específicamente para esta prueba.
- **El paquete de descarga de Prestashop viene "doblemente zipeado"**: el zip de la release contiene otro `prestashop.zip` dentro, y el `index.php` del zip exterior es solo un instalador, no el front controller real. Si se descomprime todo junto sin fijarse, el `index.php` que queda es el equivocado y la tienda no carga (queda "pillada" en la pantalla de instalación aunque ya esté instalada).
- **openssl en PHP para Windows**: el instalador fallaba en `openssl_pkey_get_details()` al generar `parameters.php`. Hubo que apuntar la variable de entorno `OPENSSL_CONF` al `openssl.cnf` que trae el propio PHP para que el instalador pudiera generar las claves.
- **`PUBLIC_PATH` de Webpack sin barra final**: usar `/themes/falcon/assets` (sin `/` al final) rompe la carga de *chunks* JS/CSS asíncronos de Webpack (Prestashop concatena la ruta a pelo y genera URLs como `.../assetsjs/archivo.js`, un 404 encadenado). Con la barra final (`/themes/falcon/assets/`) se resuelve.
- **La caché de Smarty no se entera sola de los cambios de assets.** Después de recompilar con Webpack, si no se ve el cambio en la tienda, hay que vaciar `cache/smarty/cache` y `cache/smarty/compile` (o hacerlo desde el Back Office en Parámetros avanzados > Rendimiento).
- **Analogía con WordPress que me ayudó**: los `{hook}` de Smarty/Prestashop son conceptualmente como los `do_action`/`apply_filters` de WordPress, y sobrescribir un `.tpl` del tema es equivalente a un *template override* de un child theme — una vez hecha esa asociación mental, moverme por las plantillas fue mucho más intuitivo.

## Estructura relevante

```
_dev/                          código fuente (SCSS, JS, config de Webpack)
templates/catalog/             plantillas Smarty de categoría y producto
config/theme.yml               metadatos del tema
assets/                        salida compilada (generada, no versionada salvo /img)
```
