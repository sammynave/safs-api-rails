require 'graphql/batch'

class RelatedRecordLoader < GraphQL::Batch::Loader
  def initialize(model, parent_id_key)
    @model = model
    @parent_id_key = parent_id_key
  end

  def perform(parent_ids)
    results = @model.where({@parent_id_key => parent_ids})
    parent_ids.each{ |parent_id|
      this_parent_results = results.select{ |record|
        record[@parent_id_key] === parent_id
      }
      fulfill(parent_id, this_parent_results)
    }
    parent_ids.each { |id| fulfill(id, nil) unless fulfilled?(id) }
  end
end 
