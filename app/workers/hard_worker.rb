class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    p "From worker."
  end
end
