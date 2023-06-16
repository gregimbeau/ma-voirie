module ApplicationHelper

  def check_if_admin
    unless current_user&.is_admin
      flash[:alert] = "Action réservée aux administrateurs !"
      redirect_to root_path
    end
  end

  def check_if_admin_or_creator
    if Report.find(params['id']).status_id == 1
      unless current_user&.is_admin || current_user&.id == Report.find(params['id']).user_id
        flash[:alert] = "Cet évènement n'est pas encore validé !"
        redirect_to root_path
      end
    end
  end
end
