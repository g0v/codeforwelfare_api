class Api::SearchesController < ApplicationController
  skip_before_filter :authenticate_admin_user!

  def show
    q = JSON.parse params[:q]
    tag_ids = []
    q['category'].each do |category|
      tag = Tag.key('category').find_by_value(category)
      tag_ids << tag.id if tag.present?
    end

    rule_ids = RuleTag.where(:tag_id => tag_ids).map {|c| c.rule_id}.uniq
    rules = Rule.where(:id => rule_ids)
    render :json => rules.to_json
  end
end
