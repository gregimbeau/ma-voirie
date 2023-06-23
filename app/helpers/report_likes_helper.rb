module ReportLikesHelper

  def already_exist?(report)
    ReportLike.where(user: current_user,report_id:report.id).length > 0
  end

end
