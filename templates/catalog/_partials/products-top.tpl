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
<div id="js-product-list-top" class="row products-selection align-items-center mb-4 mt-n2">
  <div class="col-auto mt-2">
    {block name='sort_by'}
      {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
    {/block}
  </div>

  {* El diseño no incluye el selector de "productos por página" ni el
     conmutador rejilla/lista, así que no se pintan. El listado es siempre
     rejilla, que es como está maquetado. *}

  <div class="col-sm-auto col-12 mt-2 d-md-none ml-auto">
    {if !empty($listing.rendered_facets)}
      <button data-target="#mobile_filters" data-toggle="modal" class="btn btn-secondary d-sm-inline-block d-none">
        {l s='Filtrar' d='Shop.Theme.Actions'}
      </button>
      <button data-target="#mobile_filters" data-toggle="modal" class="btn btn-secondary btn-block d-sm-none">
        {l s='Filtrar' d='Shop.Theme.Actions'}
      </button>
    {/if}
  </div>
</div>
