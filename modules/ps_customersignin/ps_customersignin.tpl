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
<div class="col flex-grow-0 header-top__block header-top__block--user">
  <a
    class="header-top__link"
    rel="nofollow"
    href="{$urls.pages.authentication}?back={$urls.current_url|urlencode}"
    {if $logged}
      title="{l s='View my customer account' d='Shop.Theme.Customeraccount'}"
    {else}
      title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}"
    {/if}
  >
    <div class="header-top__icon-container">
      {* El diseño usa el icono a línea, no el relleno de Material Icons. *}
      <svg class="header-top__svg-icon header-top__svg-icon--account" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true" focusable="false"><g transform="translate(4.501 2.250)"><path d="M11.249 3.75L11.999 3.75L11.249 3.75ZM7.499 0L7.499 -0.75L7.499 0ZM0 17.868L-0.7499 17.8558C-0.754759 18.1532 -0.583298 18.4255 -0.312892 18.5496L0 17.868ZM7.499 10.4905L7.499 11.2405L7.499 10.4905ZM14.998 17.868L15.3106 18.5497C15.5812 18.4257 15.7528 18.1534 15.7479 17.8558L14.998 17.868ZM7.499 19.5L7.50002 18.75L7.499 18.75L7.499 19.5ZM11.249 3.75L10.499 3.75C10.499 4.54565 10.1829 5.30871 9.62032 5.87132L10.1507 6.40165L10.681 6.93198C11.5249 6.08807 11.999 4.94347 11.999 3.75L11.249 3.75ZM10.1507 6.40165L9.62032 5.87132C9.05771 6.43393 8.29465 6.75 7.499 6.75L7.499 7.5L7.499 8.25C8.69247 8.25 9.83707 7.77589 10.681 6.93198L10.1507 6.40165ZM7.499 7.5L7.499 6.75C6.70335 6.75 5.94029 6.43393 5.37768 5.87132L4.84735 6.40165L4.31702 6.93198C5.16093 7.77589 6.30553 8.25 7.499 8.25L7.499 7.5ZM4.84735 6.40165L5.37768 5.87132C4.81507 5.30871 4.499 4.54565 4.499 3.75L3.749 3.75L2.999 3.75C2.999 4.94347 3.47311 6.08807 4.31702 6.93198L4.84735 6.40165ZM3.749 3.75L4.499 3.75C4.499 2.95435 4.81507 2.19129 5.37768 1.62868L4.84735 1.09835L4.31702 0.56802C3.47311 1.41193 2.999 2.55653 2.999 3.75L3.749 3.75ZM4.84735 1.09835L5.37768 1.62868C5.94029 1.06607 6.70335 0.75 7.499 0.75L7.499 0L7.499 -0.75C6.30553 -0.75 5.16093 -0.275894 4.31702 0.56802L4.84735 1.09835ZM7.499 0L7.499 0.75C8.29465 0.75 9.05771 1.06607 9.62032 1.62868L10.1507 1.09835L10.681 0.56802C9.83707 -0.275894 8.69247 -0.75 7.499 -0.75L7.499 0ZM10.1507 1.09835L9.62032 1.62868C10.1829 2.19129 10.499 2.95435 10.499 3.75L11.249 3.75L11.999 3.75C11.999 2.55653 11.5249 1.41193 10.681 0.56802L10.1507 1.09835ZM0 17.868L0.7499 17.8802C0.778821 16.1094 1.5026 14.4208 2.76516 13.1787L2.23918 12.644L1.71319 12.1094C0.170072 13.6275 -0.714552 15.6913 -0.7499 17.8558L0 17.868ZM2.23918 12.644L2.76516 13.1787C4.02771 11.9366 5.72788 11.2405 7.499 11.2405L7.499 10.4905L7.499 9.74047C5.3343 9.74047 3.25632 10.5913 1.71319 12.1094L2.23918 12.644ZM7.499 10.4905L7.499 11.2405C9.27012 11.2405 10.9703 11.9366 12.2328 13.1787L12.7588 12.644L13.2848 12.1094C11.7417 10.5913 9.6637 9.74047 7.499 9.74047L7.499 10.4905ZM12.7588 12.644L12.2328 13.1787C13.4954 14.4208 14.2192 16.1094 14.2481 17.8802L14.998 17.868L15.7479 17.8558C15.7126 15.6913 14.8279 13.6275 13.2848 12.1094L12.7588 12.644ZM14.998 17.868L14.6854 17.1863C12.4312 18.2199 9.97992 18.7534 7.50002 18.75L7.499 19.5L7.49798 20.25C10.1944 20.2537 12.8596 19.6736 15.3106 18.5497L14.998 17.868ZM7.499 19.5L7.499 18.75C4.93312 18.75 2.49968 18.1902 0.312892 17.1864L0 17.868L-0.312892 18.5496C2.06632 19.6418 4.71288 20.25 7.499 20.25L7.499 19.5Z"/></g></svg>
    </div>
  </a>
</div>
