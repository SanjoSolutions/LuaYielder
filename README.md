# Yielder

A library for helping with yielding in long-running processes. This library can save add-on developers some work.

## Things included

* **Yielder.yieldAndResume**: a function for yielding and scheduling a resume. Can only be used in coroutines.
* **Yielder.createYielder**: a function which creates a yielder. The yielder has the methods "yield" and "resume".
* **Yielder.createYielderWithTimeTracking**: a function which creates a yielder with time tracking. In addition to the yielder that is created by "Yielder.createYielder", this yielder has the methods "hasRunOutOfTime" and "yieldAndResumeWhenHasRunOutOfTime".
