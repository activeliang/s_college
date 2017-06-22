module Admin::VipPricesHelper

  def render_vip_price_state(item)
    if item.is_hidden
      content_tag(:i, "", class: "fa fa-times-circle-o", style: "color: #e4393c;")
    else
      content_tag(:i, "", class: "fa fa-check-square-o", style: "color: #2dbe60;")
    end
  end

  def render_vip_price_state_btn(item)
    if item.is_hidden
      link_to("点击上架", update_state_admin_vip_price_path(item), method: :post, class: "btn btn-success btn-xs")
    else
      link_to("点击下架", update_state_admin_vip_price_path(item), method: :post, class: "btn btn-primary btn-xs")
    end
  end
end
