{**
 * Override del tema: el diseño solo muestra dos enlaces en la barra del
 * menú, "Categorías" y "Promociones", en vez del árbol de categorías que
 * pinta el módulo por defecto.
 *}
{assign var=_catUrl value=$menu.children.0.url|default:'#'}
{assign var=_promoUrl value=$link->getPageLink('prices-drop')}

<div class="d-none d-md-block col-12 header-top__block header-top__block--menu mt-1">
  <div class="main-menu" id="_desktop_top_menu">
    {* El diseño abre la barra con un icono de menú de tres filetes. En
       escritorio los dos enlaces ya están a la vista, así que el icono es
       decorativo: se marca como tal para los lectores de pantalla en vez de
       dejar un control que no lleva a ninguna parte. *}
    <span class="main-menu__toggle" aria-hidden="true">
      <span class="main-menu__toggle-bar"></span>
      <span class="main-menu__toggle-bar"></span>
      <span class="main-menu__toggle-bar"></span>
    </span>

    <ul class="main-menu__dropdown js-main-menu h-100" role="navigation" data-depth="0">
      <li class="h-100 main-menu__item--0 category main-menu__item main-menu__item--top" id="top-categorias">
        <a class="d-md-flex w-100 h-100 main-menu__item-link main-menu__item-link--top main-menu__item-link--nosubmenu"
           href="{$_catUrl}" data-depth="0">
          <span class="align-self-center">{l s='Categorías' d='Modules.Mainmenu.Admin'}</span>
        </a>
      </li>
      <li class="h-100 main-menu__item--0 promotions main-menu__item main-menu__item--top" id="top-promociones">
        <a class="d-md-flex w-100 h-100 main-menu__item-link main-menu__item-link--top main-menu__item-link--nosubmenu"
           href="{$_promoUrl}" data-depth="0">
          <span class="align-self-center">{l s='Promociones' d='Modules.Mainmenu.Admin'}</span>
        </a>
      </li>
    </ul>
  </div>
</div>
