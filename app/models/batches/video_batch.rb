class Batches::VideoBatch < Batch
  def self.policy_class
    VideoBatchPolicy
  end
end
