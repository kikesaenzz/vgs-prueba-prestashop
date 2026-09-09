{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{block name='header_banner'}
    <div class="header-banner">
        {hook h='displayBanner'}
    </div>
{/block}

{* La franja amarilla, el buscador y el menú deben moverse y desaparecer
   juntos como un único bloque al hacer scroll, no por separado: el
   envoltorio "sticky" (que useStickyElement.js fija con position:fixed)
   pasa a abarcar tanto header_nav como header_top en vez de solo el
   segundo. *}
<div class="js-header-top-wrapper">
    <div class="js-header-top">

        {block name='header_nav'}
            {* Barra superior amarilla del diseño: horario/teléfono a la izquierda y
               aviso de envíos a la derecha. Los textos son los del Figma. *}
            <nav class="header-nav vgs-preheader">
                <div class="container">
                    <div class="vgs-preheader__row">
                        <span class="vgs-preheader__item">{l s='Lun-Vie 9:00h - 19:00h | 976 123 456' d='Shop.Theme.Global'}</span>
                        <span class="vgs-preheader__item vgs-preheader__item--end">{l s='Envíos gratuítos por compras SUPERIORES a 50€' d='Shop.Theme.Global'}</span>
                    </div>
                    <div class="row align-items-center d-none">
                        {hook h='displayNav1'}
                        {hook h='displayNav2'}
                    </div>
                </div>
            </nav>
        {/block}

        {block name='header_top'}
            <div class="header-top">
                <div class="header-top__content pt-md-3 pb-md-0 py-2">

                    <div class="container">

                        <div class="row header-top__row">

                            <div class="col flex-grow-0 header-top__block header-top__block--menu-toggle d-block d-md-none">
                                <a
                                        class="header-top__link"
                                        rel="nofollow"
                                        href="#"
                                        data-toggle="modal"
                                        data-target="#mobile_top_menu_wrapper"
                                >
                                    <div class="header-top__icon-container">
                                        <span class="header-top__icon material-icons">menu</span>
                                    </div>
                                </a>
                            </div>

                            {* El diseño no lleva logotipo en la cabecera. *}

                            {hook h='displayTop'}
                        </div>

                    </div>
                </div>
            </div>

    </div>
</div>
{hook h='displayNavFullWidth'}

    {* Las migas y el título de categoría son bandas a ancho completo en el
       diseño, por eso se pintan aquí (fuera del .container del layout) y no
       dentro del contenido. *}
    {block name='vgs_breadcrumb_band'}
        {if isset($breadcrumb) && $breadcrumb.links|count > 1}
            <div class="vgs-breadcrumb">
                <div class="container">
                    <nav aria-label="breadcrumb" data-depth="{$breadcrumb.count}">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item breadcrumb-item--home">
                                <a href="{$urls.pages.index}" aria-label="{l s='Home' d='Shop.Theme.Global'}">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M3 10.5 12 3l9 7.5V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1v-9.5Z"/>
                                    </svg>
                                </a>
                            </li>
                            {foreach from=$breadcrumb.links item=path name=breadcrumb}
                                {if !$smarty.foreach.breadcrumb.first}
                                    <li class="breadcrumb-item{if $smarty.foreach.breadcrumb.last} active{/if}"
                                        {if $smarty.foreach.breadcrumb.last}aria-current="page"{/if}>
                                        {if !$smarty.foreach.breadcrumb.last}<a href="{$path.url}">{/if}
                                            {$path.title}
                                        {if !$smarty.foreach.breadcrumb.last}</a>{/if}
                                    </li>
                                {/if}
                            {/foreach}
                        </ol>
                    </nav>
                </div>
            </div>
        {/if}
    {/block}

    {* Entre las migas y el título el diseño coloca una banda de imagen a
       ancho completo (206px de alto) con la portada de la categoría. *}
    {block name='vgs_category_banner'}
        {* No hay un tipo de imagen "large" registrado para categorías en esta
           instalación (solo small_default y category_default, pensados para
           miniaturas), así que $category.image.large.url resolvía a una
           imagen de 141x180 estirada a cientos de píxeles de ancho. Se sirve
           un archivo aparte, generado a un tamaño real para la banda. *}
        {if $page.page_name == 'category' && isset($category) && $category.image.medium.url}
            <div class="vgs-category-banner">
                <img src="{$urls.img_cat_url}{$category.id}-banner.jpg"
                     alt="{$category.name}"
                     class="vgs-category-banner__img"
                     loading="lazy">
            </div>
        {/if}
    {/block}

    {block name='vgs_category_band'}
        {if $page.page_name == 'category' && isset($category)}
            <div class="vgs-category-title">
                <div class="container">
                    <div class="vgs-category-title__inner">
                        {* En el diseño el icono de la banda es un pictograma distinto
                           de la foto de portada. PrestaShop guarda ese segundo
                           archivo como miniatura de menú de la categoría. *}
                        {if $category.image.medium.url}
                            <img class="vgs-category-title__icon"
                                 src="{$urls.img_cat_url}{$category.id}-0_thumb.png"
                                 alt=""
                                 width="58" height="58" loading="lazy">
                        {/if}
                        <h1 class="vgs-category-title__text">{$category.name}</h1>
                    </div>
                </div>
            </div>
        {/if}
    {/block}
{/block}
