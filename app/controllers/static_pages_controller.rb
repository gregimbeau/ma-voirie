class StaticPagesController < ApplicationController
  def home
  end

  def map
    @reports = Report.where(is_validate: true).as_json(only: [:latitude, :longitude, :address])
  end
end
