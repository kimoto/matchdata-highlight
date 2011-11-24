require 'term/ansicolor'

class MatchData
  def highlight(*args)
    if args.empty? or args.first.kind_of?(Hash) 
      _highlight(*args)
    else
      _highlight(:begin => args[0], :end => args[1])
    end
  end

  def _highlight(options = {})
    options = {
      :begin => Term::ANSIColor.red,
      :end => Term::ANSIColor.clear,
    }.merge(options)

    marker_begin = options[:begin]
    marker_end = options[:end]

    buf = string.dup
    buf[self.begin(0), 0] = marker_begin
    buf[self.end(0) + marker_begin.size, 0] = marker_end
    buf
  end
end

class Regexp
  def highlight(target, *args)
    if match_data = self.match(target)
      match_data.highlight(*args)
    else
      target
    end
  end
end

#puts "foobar foobar BAZ".match(/(foobar)/).highlight
#puts /foobar/.match("foobar foobar BAZ").highlight("<B>", "</B>")
#puts /foobar/.highlight("foobar foobar BAZ")
#puts /foobar/.highlight("foobar foobar BAZ", :begin => '<B>', :end => '</B>')
#puts /foobar/.highlight("foobar foobar BAZ", '<B>', '</B>')

