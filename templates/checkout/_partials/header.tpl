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

{block name='header_nav'}
  <nav class="header-nav py-2">
    <div class="container">
      <div class="row">
        {* El diseño no lleva logotipo en la cabecera (igual que en
           templates/_partials/header.tpl): sin esta plantilla propia, el
           checkout de Falcon pintaba aquí el logo por defecto de la tienda
           ("my store", nunca configurado con uno real), que no forma parte
           del diseño y desentonaba con el resto del sitio. *}
        <div class="col d-none d-md-block text-right">
          {hook h='displayNav1'}
        </div>
      </div>
    </div>
  </nav>
{/block}

{block name='header_top'}
{/block}
