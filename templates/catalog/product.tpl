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
{extends file=$layout}

{block name='head' append}
  {if $product.show_price}
    <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
    <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
    <meta property="product:price:amount" content="{$product.price_amount}">
    <meta property="product:price:currency" content="{$currency.iso_code}">
  {/if}
  {if isset($product.weight) && ($product.weight != 0)}
  <meta property="product:weight:value" content="{$product.weight}">
  <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='head' prepend}
  {if $product.default_image}
    <link rel="preload" href="{$product.default_image.bySize.large_default.url}" as="image">
  {/if}
{/block}

{block name='content'}

  <section id="main">

    <div class="row product-container js-product-container">
      <div class="col-md-5 mb-4">
        {block name='page_content_container'}
            {block name='page_content'}
              {* En el diseño la ficha no lleva etiquetas sobre la imagen: el
                 descuento se muestra en la píldora junto al precio. *}
              <div class="position-relative">

                {block name='product_cover_thumbnails'}
                  {include file='catalog/_partials/product-cover-thumbnails.tpl'}
                {/block}
              </div>
            {/block}
        {/block}
        </div>
        <div class="col-md-7 mb-4">
          {block name='page_header_container'}
            {block name='page_header'}
              <h1 class="product-title">{block name='page_title'}{$product.name}{/block}</h1>
            {/block}
          {/block}

          <div class="product-information ">
            {block name='product_description_short'}
              <div id="product-description-short-{$product.id}" class="product-description-short cms-content">{$product.description_short nofilter}</div>
            {/block}

            {* Banda con marca, referencia y disponibilidad, como en el diseño. *}
            {block name='vgs_product_meta'}
              <div class="vgs-product-meta">
                {if isset($product_manufacturer->id) && $product_manufacturer->id}
                  <p class="vgs-product-meta__item mb-0">
                    <span class="vgs-product-meta__label">{l s='Marca:' d='Shop.Theme.Catalog'}</span> {$product_manufacturer->name}
                  </p>
                {/if}
                {if isset($product.reference_to_display) && $product.reference_to_display neq ''}
                  <p class="vgs-product-meta__item mb-0">
                    <span class="vgs-product-meta__label">{l s='Referencia:' d='Shop.Theme.Catalog'}</span> {$product.reference_to_display}
                  </p>
                {/if}
                {if $product.show_availability && $product.availability_message}
                  <p class="vgs-product-meta__item mb-0">
                    <span class="vgs-product-meta__label">{l s='Disponibilidad:' d='Shop.Theme.Catalog'}</span> {$product.availability_message}
                  </p>
                {/if}
              </div>
            {/block}

            {block name='product_prices'}
              {include file='catalog/_partials/product-prices.tpl'}
            {/block}

            {if $product.is_customizable && count($product.customizations.fields)}
              {block name='product_customization'}
                {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
              {/block}
            {/if}

            <div class="product-actions js-product-actions">
              {block name='product_buy'}
                <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                  <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id" class="js-product-customization-id">

                  {block name='product_variants'}
                    {include file='catalog/_partials/product-variants.tpl'}
                  {/block}

                  {block name='product_pack'}
                    {if $packItems}
                      <section class="product-pack">
                        <p class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</p>
                        <div class="card-group-vertical mb-4">
                          {foreach from=$packItems item="product_pack"}
                            {block name='product_miniature'}
                              {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack showPackProductsPrice=$product.show_price}
                            {/block}
                          {/foreach}
                        </div>
                    </section>
                    {/if}
                  {/block}

                  {block name='product_discounts'}
                    {include file='catalog/_partials/product-discounts.tpl'}
                  {/block}

                  {block name='product_add_to_cart'}
                    {include file='catalog/_partials/product-add-to-cart.tpl'}
                  {/block}

                  {block name='product_additional_info'}
                    {include file='catalog/_partials/product-additional-info.tpl'}
                  {/block}

                  {* Input to refresh product HTML removed, block kept for compatibility with themes *}
                  {block name='product_refresh'}{/block}
                </form>
              {/block}

            </div>

            {block name='hook_display_reassurance'}
              {hook h='displayReassurance'}
            {/block}

            {* Aviso de entrega. *}
            {* Aviso comercial fijo del diseño para productos físicos. *}{if $product.is_virtual == 0}
              <div class="vgs-product-delivery">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M3 6h11v9H3zM14 9h4l3 3v3h-7z"/>
                  <circle cx="7" cy="17" r="2"/>
                  <circle cx="17.5" cy="17" r="2"/>
                </svg>
                <span>{l s='Cómpralo ahora y recíbelo mañana' d='Shop.Theme.Catalog'}</span>
              </div>
            {/if}

            {* Tabla de características: dos pares etiqueta/valor por fila. *}
            {if $product.grouped_features}
              <div class="vgs-product-features">
                {foreach from=$product.grouped_features item=feature name=features}
                  {if $smarty.foreach.features.index % 2 === 0}<div class="vgs-product-features__row">{/if}
                    <div class="vgs-product-features__cell">
                      <span class="vgs-product-features__label">{$feature.name}</span>
                      <span class="vgs-product-features__value">{$feature.value|escape:'htmlall'|nl2br nofilter}</span>
                    </div>
                  {if $smarty.foreach.features.index % 2 === 1 || $smarty.foreach.features.last}</div>{/if}
                {/foreach}
              </div>
            {/if}

        </div>
      </div>
    </div>
    {* En el diseño la descripción larga no va en pestañas: es un bloque a
       ancho completo con su titular y un filete teal. Los detalles, adjuntos y
       contenido extra siguen disponibles debajo mediante las pestañas. *}
    {block name='vgs_product_info'}
      {if $product.description}
        <section class="vgs-product-info">
          <h2 class="vgs-product-info__title">{l s='Información del producto' d='Shop.Theme.Catalog'}</h2>
          <hr class="vgs-product-info__rule">
          {cms_images_block webpEnabled=$webpEnabled}
            <div class="product-description cms-content">{$product.description nofilter}</div>
          {/cms_images_block}
        </section>
      {/if}
    {/block}

    {include file="catalog/_partials/product-tabs.tpl"}

    {block name='product_footer'}
      {hook h='displayFooterProduct' product=$product category=$category}
    {/block}

    {block name='product_accessories'}
      {if $accessories}
        {include file='catalog/_partials/product-accessories.tpl' products=$accessories}
      {/if}
    {/block}

    {block name='product_images_modal'}
      {include file='catalog/_partials/product-images-modal.tpl'}
    {/block}

    {block name='page_footer_container'}
      <footer class="page-footer">
        {block name='page_footer'}
          <!-- Footer content -->
        {/block}
      </footer>
    {/block}
  </section>

{/block}
