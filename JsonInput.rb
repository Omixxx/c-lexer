class Persona
  attr_accessor :name, :method, :startLie, :endLine, :classPath, :readabilityScore, :label

  def initialize(name, method, startLine, endLine, classPath, readabilityScore, label)
    @name = name
    @method = method
    @startLine = startLine
    @endLine = endLine
    @classPath = classPath
    @readabilityScore = readabilityScore
    @label = label
  end
end
