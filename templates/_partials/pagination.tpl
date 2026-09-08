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


{block name='pagination_page_list'}
  {if $pagination.should_be_displayed}
    {* Pie del listado según el diseño: recuento a la izquierda y paginación a
       la derecha, con "Anterior"/"Siguiente" rotulados. *}
    <div class="vgs-listing-foot">
      <p class="vgs-listing-foot__count">
        {l s='Mostrando %from% - %to% de %total% artículos'
           sprintf=['%from%' => $pagination.items_shown_from, '%to%' => $pagination.items_shown_to, '%total%' => $pagination.total_items]
           d='Shop.Theme.Catalog'}
      </p>

      <nav aria-label="{l s='Pagination' d='Shop.Theme.Global'}">
        <ul class="pagination">
          {foreach from=$pagination.pages item="page"}
            <li class="page-item{if $page.current} active current{/if}{if $page.type === 'spacer'} disabled{/if}{if $page.type === 'previous'} previous{/if}{if $page.type === 'next'} next{/if}">
              {if $page.type === 'spacer'}
                <span class="page-link">&hellip;</span>
              {else}
                <a
                  rel="{if $page.type === 'previous'}prev{elseif $page.type === 'next'}next{else}nofollow{/if}"
                  href="{$page.url}"
                  class="page-link {['disabled' => !$page.clickable, 'js-search-link' => true]|classnames}"
                >
                  {if $page.type === 'previous'}
                    <svg class="page-link__arrow" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.67" aria-hidden="true">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M15 6l-6 6 6 6"/>
                    </svg>
                    <span>{l s='Anterior' d='Shop.Theme.Actions'}</span>
                  {elseif $page.type === 'next'}
                    <span>{l s='Siguiente' d='Shop.Theme.Actions'}</span>
                    <svg class="page-link__arrow" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.67" aria-hidden="true">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M9 6l6 6-6 6"/>
                    </svg>
                  {else}
                    {$page.page}
                  {/if}
                </a>
              {/if}
            </li>
          {/foreach}
        </ul>
      </nav>
    </div>
  {/if}
{/block}
