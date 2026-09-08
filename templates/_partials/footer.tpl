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
<div class="container">
  <div class="row">
    {block name='hook_footer_before'}
      {hook h='displayFooterBefore'}
    {/block}
  </div>
</div>
<div class="footer-container">
  <div class="container">
    <div class="row">

      {block name='vgs_footer_contact'}
        {* Bloque de contacto del diseño. Los datos son los del maquetado. *}
        <div class="col-12 col-lg-4 mb-5 mb-lg-0">
          <div class="vgs-footer-contact">
            <p class="vgs-footer-contact__item mb-0">
              <svg class="vgs-footer-contact__icon" viewBox="0 0 24 24" stroke-width="1.5" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3 5c0-1.1.9-2 2-2h2.3a2 2 0 0 1 1.9 1.5l.7 2.8a2 2 0 0 1-.5 1.9l-1.2 1.2a11 11 0 0 0 5.4 5.4l1.2-1.2a2 2 0 0 1 1.9-.5l2.8.7A2 2 0 0 1 21 16.7V19a2 2 0 0 1-2 2h-1C9.2 21 3 14.8 3 7V5Z"/>
              </svg>
              <span>{l s='+34 976 123 456' d='Shop.Theme.Global'}</span>
            </p>
            <p class="vgs-footer-contact__item mb-0">
              <svg class="vgs-footer-contact__icon" viewBox="0 0 24 24" stroke-width="1.5" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3 6h18v12H3z"/>
                <path stroke-linecap="round" stroke-linejoin="round" d="m3 6 9 7 9-7"/>
              </svg>
              <span>{l s='info@dominio.com' d='Shop.Theme.Global'}</span>
            </p>
            <p class="vgs-footer-contact__item mb-0">
              <svg class="vgs-footer-contact__icon" viewBox="0 0 24 24" stroke-width="1.5" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 21s7-6.5 7-11.5A7 7 0 0 0 5 9.5C5 14.5 12 21 12 21Z"/>
                <circle cx="12" cy="9.5" r="2.2"/>
              </svg>
              <span>{l s='C/ Calle del cliente nº 45' d='Shop.Theme.Global'}<br>{l s='50011, Zaragoza' d='Shop.Theme.Global'}</span>
            </p>
          </div>
        </div>
      {/block}

      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
    </div>
    <div class="row">
      {block name='hook_footer_after'}
        {hook h='displayFooterAfter'}
      {/block}
    </div>

    {block name='vgs_footer_bottom'}
      <div class="vgs-footer-bottom">
        <p class="vgs-footer-bottom__text">{l s='Todos los derechos reservados - Desarrollado por VGS' d='Shop.Theme.Global'}</p>
      </div>
    {/block}
  </div>
</div>
