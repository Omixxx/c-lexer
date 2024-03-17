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
    :manual_flag
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
    manual_flag
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
    @manual_flag = manual_flag
  end
end
