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
{extends file='layouts/layout-both-columns.tpl'}

{block name='right_column'}{/block}

{* En el diseño las categorías y los filtros comparten una única caja con
   borde teal, así que se envuelve el contenido de la columna izquierda. *}
{block name='left_column'}
  <div id="left-column" class="col-12 col-md-4 col-lg-3">
    <div class="vgs-sidebar">
      {if $page.page_name == 'product'}
        {hook h='displayLeftColumnProduct' product=$product category=$category}
      {else}
        {hook h="displayLeftColumn"}
      {/if}
    </div>
  </div>
{/block}

{block name='content_wrapper'}
  <div id="content-wrapper" class="js-content-wrapper left-column col-12 col-md-8 col-lg-9">
    {hook h="displayContentWrapperTop"}
    {block name='content'}
      <p>Hello world! This is HTML5 Boilerplate.</p>
    {/block}
    {hook h="displayContentWrapperBottom"}
  </div>
{/block}
