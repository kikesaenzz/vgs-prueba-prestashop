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
{extends file='page.tpl'}

{* El enunciado solo pide maquetar Categoría y Ficha de producto: la portada
   no forma parte del alcance y se queda con el contenido de demostración de
   Falcon, que ya no encaja con un catálogo solo de cosmética (el banner
   "20% OFF ON CLOTHES", el bloque de texto de relleno...). En vez de dejar
   esa página inconsistente a la vista, se redirige a Cosmética, la única
   categoría real de esta tienda.

   Un <meta http-equiv="refresh"> con "&" sin codificar en la URL es
   ambiguo (algunos navegadores no decodifican la entidad "&amp;" dentro de
   ese atributo antes de usarla, y la URL les llega rota), así que el
   redirect va solo por JavaScript; el enlace visible cubre el caso, ya
   raro en 2026, de JavaScript deshabilitado. *}
{assign var=_cosmeticaUrl value=$link->getCategoryLink(10)}

{block name='page_content_container'}
  <section id="content" class="page-home">
    {block name='page_content_top'}{/block}

    {block name='page_content'}
      <div class="text-center py-5">
        <p>{l s='Redirigiendo al catálogo…' d='Shop.Theme.Global'}</p>
        <a href="{$_cosmeticaUrl}">{l s='Continuar' d='Shop.Theme.Actions'}</a>
      </div>
      {* Link::getCategoryLink() devuelve la URL con "&amp;" (pensada para
         un atributo href), así que hay que decodificarla antes de meterla
         en una cadena de JavaScript, donde "&amp;" se quedaría literal. *}
      <script>window.location.replace('{$_cosmeticaUrl|unescape:'html'|escape:'javascript':'UTF-8' nofilter}');</script>
    {/block}
  </section>
{/block}
