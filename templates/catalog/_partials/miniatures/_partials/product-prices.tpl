{block name='product_price_and_shipping'}
  {if $product.show_price}
    {* El diseño ordena el precio actual, después el anterior tachado y por
       último el porcentaje de descuento dentro de una píldora. *}
    <div class="product-miniature__pricing text-left">
      {hook h='displayProductPriceBlock' product=$product type="before_price"}

      <span class="price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">{$product.price}</span>

      {if $product.has_discount}
        {hook h='displayProductPriceBlock' product=$product type="old_price"}
        <span class="price price--regular" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>

        {if $product.discount_type === 'percentage'}
          {* El diseño escribe el porcentaje sin decimales. *}
          <span class="product-miniature__discount">{$product.discount_percentage|regex_replace:'/[.,]\d+/':''}</span>
        {/if}
      {/if}

      {hook h='displayProductPriceBlock' product=$product type='unit_price'}

      {hook h='displayProductPriceBlock' product=$product type='weight'}
    </div>
  {/if}
{/block}
