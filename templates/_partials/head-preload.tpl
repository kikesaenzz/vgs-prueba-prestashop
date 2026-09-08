{$themeDir = _PS_THEME_DIR_}
{$preloadFilePath = "`$themeDir`assets/preload.html"}
{$urlsWithCdn = $urls.img_ps_url|replace:'/img/':'/'}

{if file_exists($preloadFilePath)}
  {capture name="preloadBlock"}{include file=$preloadFilePath}{/capture}

  {* El reemplazo se ancla en `href="/themes/` en vez de en `/themes/` suelto.
     Falcon da por hecho que la tienda cuelga de la raíz del dominio; si está en
     un subdirectorio, PUBLIC_PATH ya incluye ese prefijo y el reemplazo genérico
     producía URLs duplicadas del tipo /tienda + http://.../tienda/themes/...
     que devolvían 403. Así solo se reescribe cuando la ruta es realmente
     relativa a la raíz, y se sigue soportando el CDN. *}
  {$smarty.capture.preloadBlock|replace:'href="/themes/':"href=\"`$urlsWithCdn`themes/" nofilter}
{/if}

