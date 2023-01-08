Yielder = {}

function Yielder.yieldAndResume()
  local thread = coroutine.running()
  C_Timer.After(0, function ()
    Coroutine.resumeWithShowingError(thread)
  end)
  coroutine.yield()
end

function Yielder.createYielder()
  local yielder
  yielder = {
    thread = coroutine.running(),
    resume = function(...)
      if coroutine.status(yielder.thread) == 'suspended' then
        return Coroutine.resumeWithShowingError(yielder.thread, ...)
      end
    end,
    yield = function()
      C_Timer.After(0, yielder.resume)
      coroutine.yield()
    end
  }
  return yielder
end

function Yielder.createYielderWithTimeTracking(timePerRun)
  local yielder = Yielder.createYielder()

  timePerRun = (timePerRun or 1 / 60) * 1000
  local start = debugprofilestop()

  local resume = yielder.resume
  yielder.resume = function (...)
    start = debugprofilestop()
    return resume(...)
  end

  yielder.hasRunOutOfTime = function()
    return debugprofilestop() - start >= timePerRun
  end

  yielder.yieldAndResumeWhenHasRunOutOfTime = function ()
    if self:hasRunOutOfTime() then
      self:yield()
    end
  end

  return yielder
end
