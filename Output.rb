class Output
  attr_accessor(
    :name,
    :startLine,
    :endLine,
    :classPath,
    :readabilityScore,
    :label,
    :original_method,
    :abstract_method,
    :model_prediction,
    :is_diff,
    :partially_detokenized_method,
    :detokenized_method
  )

  def initialize(
    name,
    startLine,
    endLine,
    classPath,
    readabilityScore,
    label,
    original_method,
    abstract_method,
    model_prediction,
    is_diff,
    partially_detokenized_method,
    detokenized_method
  )
    @name = name
    @startLine = startLine
    @endLine = endLine
    @classPath = classPath
    @readabilityScore = readabilityScore
    @label = label
    @original_method = original_method
    @abstract_method = abstract_method
    @model_prediction = model_prediction
    @is_diff = is_diff
    @partially_detokenized_method = partially_detokenized_method
    @detokenized_method = detokenized_method
  end
end
