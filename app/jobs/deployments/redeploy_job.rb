module Deployments
class RedeployJob < Struct.new(:deployment_id)

  def enqueue(job)
    update_status("Job created and queued, waiting for deployment to begin.")
  end

  def perform
    deployment = Deployment.find(deployment_id)
    deployment.rebuild_deployment
  end

  def success(job)
    deployment = Deployment.find(deployment_id)
    deployment.finish
  end

  def error(job, exception)
    update_status("ERROR #{exception.message}")
    deployment = Deployment.find(deployment_id)
    deployment.dlog("ERROR in deployment: #{exception.message}")
    deployment.dlog(exception.backtrace)
  end

  def failure(job)
    # Roll back the job
    # TODO Actually roll back deployment
    #   Need to review status's for redployment and have case statement
    #   for which status we failed on and roll back depending
    update_status("ERROR Job failed - Rolling back deployment")
    deployment = Deployment.find(deployment_id)
    deployment.dlog("Rolling back deployment")
    project = Project.find(deployment.project_id)
    project.destroy_all
    project.instances.each do |inst|
      inst.update_attributes(:deployment_started => false, :deployment_completed => false)
    end
    deployment.finish
    deployment.update_status("Deployment failed")
    deployment.dlog("Rollback completed.")
    update_status("Deployment Failed")
  end

  private

  def update_status(status)
    deployment = Deployment.find(deployment_id)
    deployment.update_attributes(:status => status)
  end

end
end
