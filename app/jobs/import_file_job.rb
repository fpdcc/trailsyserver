class ImportFileJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    logger.info "job arguments = #{job.arguments}"
    update = job.arguments[2]
    update.status = "success"
    #update.job = job
    update.save
    
  end

  def perform(path, data_type, update)
    Update.parse_csv(path, data_type, update)
  end

end
