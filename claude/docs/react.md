# React

<preferences>
  Separate out javascript/typescript code from jsx/tsx code in a separate file.
  Decompose large components into smaller re-usable components.
  Use simple function-based components with hooks instead of class-based components especially when binding to `this` isn't required.
  If a Component was created using ES6 syntax and the method was defined without using an arrow function syntax, manually bind the method’s `this` to the Component instance in the `constructor` method.
  No Need to Bind When Using ES6 Component Classes with Arrow Functions.
  Avoid the Anonymous Function Hack if Possible.
  Add Debuggers to Implicit Return Arrow Functions.
  A component’s props should be used for data that is passed into the component from the outside, typically from a parent component or the redux store. As such, a component cannot change its props; change only comes from the outside when the component receives new props . In this regard, props can be thought of as a mechanism of communication between components.
  A component’s `state` should be used for data whose changes are managed by the component. Object-oriented programmers can think of the `state` as the component’s member variables or instance variables. When a component mounts, its `state` is initiated to a certain value but the component can change this `state` over time through the `setState` method.
  Minimize Number of Stateful Components, and rely on pure functional components
  In constructor method make sure super(props) is the first line.
  Constructor method is only required when you are setting initial state or binding methods to this.
  In constructor method set the initial `state` by `this.state = { value: "foo" }` instead of using `setState`.
  When optimising for performance prefer `shouldComponentUpdate` and `React.PureComponent`.
  Also checkout javascript and typescript preferences: `@~/.claude/docs/javascript_typescript.md`
</preferences>

<concepts>
  <concept>
  useState
    <use_case>
      Tracking form inputs (e.g., text fields, checkboxes)
      Dynamic values (e.g., counters, loading flags)
      Toggle UI states (e.g., modals, dropdowns)
    </use_case>

    <pitfalls>
      Async Updates: State updates are asynchronous:
      ```jsx
      const [count, setCount] = useState(0);
      setCount(count + 1); // May not update immediately.
      ```
      Fix: Use the functional update form:
      ```jsx
      setCount(prev => prev + 1);
      ```
      Stale closures: If state is used in useEffect dependencies, it may become stale
      Overuse: Avoid using useState for derived data (calculate it on the fly instead)
    </pitfalls>

    <best_practices>
      Minimize state: Don’t store derivable data (e.g., compute fullName from firstName + lastName)
      Group related state: Prefer one useState with an object over multiple states
      ```jsx
      const [user, setUser] = useState({ name: '', age: 0 });
      ```
      Initialization: Pass a function for expensive initial state (lazy initialization)
      ```jsx
      const [data, setData] = useState(() => fetchInitialData());
      ```
    </best_practices>

    <when_not_to_use>
      Shared state: Use useContext or state management (Redux) instead
      Server data: use other libraries for API data
    </when_not_to_use>
  </concept>

  <concept>
  useEffect
    <use_case>
      Fetching data on component mount
      Setting up event listeners or timers
      Syncing with external systems (e.g., analytics)
    </use_case>

    <pitfalls>
      Infinite loops: Missing dependencies or incorrect updates:
      ```jsx
      useEffect(() => {
        setData(data + 1); // Triggers re-render → infinite loop
      }, [data]);
      ```
      Stale closures: If dependencies are omitted, effects capture stale values
      Memory leaks: Forgetting to clean up subscriptions:
      ```jsx
      useEffect(() => {
        const timer = setInterval(() => {}, 1000);
        return () => clearInterval(timer); // Cleanup!
      }, []);
      ```
    </pitfalls>

    <best_practices>
      Specify dependencies: Always include all dependencies (or disable linter intentionally)
      Separate concerns: Use multiple useEffect hooks for unrelated logic
      Cleanup: Return a cleanup function for subscriptions/timeouts
      Avoid race conditions: Cancel async tasks in cleanup:
      ```jsx
      useEffect(() => {
        let isMounted = true;
        fetchData().then(data => {
          if (isMounted) setData(data);
        });
        return () => { isMounted = false };
      }, []);
      ```
    </best_practices>

    <when_not_to_use>
      User events: Handle clicks/inputs with event handlers, not useEffect
      Derived state: Use useMemo instead of recalculating in useEffect.
    </when_not_to_use>
  </concept>

  <concept>
  useContext
    <pitfalls>
      Performance: Context re-renders all consumers when value changes. Fix: Memoize the context value or split contexts
      Overuse: Not a replacement for state management (Redux) in complex apps
      Default values: Ensure defaults make sense (undefined may cause errors)
    </pitfalls>

    <best_practices>
      Small, focused contexts: Split into ThemeContext, UserContext, etc
      Memoize providers: Prevent unnecessary re-renders:
      ```jsx
      const [user, setUser] = useState(null);
      const value = useMemo(() => ({ user, setUser }), [user]);
      return <UserContext.Provider value={value}>...</UserContext.Provider>;
      ```
      Custom hooks: Wrap useContext for cleaner usage:
      ```jsx
      const useUser = () => useContext(UserContext);
      ```
    </best_practices>

    <when_not_to_use>
      High-frequency updates: Use state management (Redux) instead
      Component-local state: Prefer useState or useReducer
    </when_not_to_use>
    Use the simplest tool for the job. Reach for useState → useReducer → useContext → Redux in that order.
  </concept>


  <concept>
  useReducer

    <use_case>
      Forms with multiple fields (e.g., registration forms)
      State machines (e.g., fetch status: idle, loading, success, error)
      When useState becomes unwieldy (nested state updates)
    </use_case>

    <pitfalls>
      Overkill for simple state: Use useState if logic is trivial
      Immutability: Must return a new state object (no direct mutations)
      ```jsx
      // ❌ Wrong (mutates state)
      state.name = action.name;
      return state;

      // ✅ Correct (returns new state)
      return { ...state, name: action.name };
      ```
    </pitfalls>
    <best_practices>
      Separate reducers: Split logic into smaller functions
      Type safety: Use TypeScript or action constants to avoid typos
      Initializer function: For lazy initialization (like useState)
    </best_practices>

    <when_not_to_use>
      Local UI state (e.g., toggles, simple counters)
      When useState suffices
    </when_not_to_use>
  </concept>

  <concept>
  useCallback
    <use_case>
      Passing callbacks to memoized children (React.memo)
      Dependency arrays in useEffect
    </use_case>

    <pitfalls>
      Overuse: Wrapping every function hurts performance
      Stale closures: If dependencies are wrong, it captures old values
    </pitfalls>

    <best_practices>
    </best_practices>
      Only use when needed:
      ```jsx
      // ✅ Good (memoized for `React.memo` child)
      const handleClick = useCallback(() => {}, []);

      // ❌ Unnecessary (inline function is fine)
      <button onClick={() => {}} />
      ```
      Specify dependencies: Empty `[]` = runs once (like useEffect)

    <when_not_to_use>
      Inline event handlers (e.g., `<button onClick={() => {}}>`).
      Functions that don’t cause re-renders
    </when_not_to_use>
  </concept>

  <concept>
  useMemo and React.memo

    <use_case>
      useMemo: Heavy computations (e.g., sorting large arrays)
      React.memo: Pure components (e.g., lists, tables)
    </use_case>

    <pitfalls>
      Premature optimization: Don’t memoize everything
      Shallow comparisons: React.memo only checks props (not deep equality)
    </pitfalls>

    <best_practices>
      Profile first: Use React DevTools to confirm bottlenecks
      Custom comparison: React.memo(Component, areEqual) for deep checks:
      ```jsx
      // ✅ `useMemo` example
      const sortedList = useMemo(() => hugeList.sort(), [hugeList]);

      // ✅ `React.memo` example
      const User = React.memo(({ name }) => <div>{name}</div>);
      ```
    </best_practices>

    <when_not_to_use>
      Trivial computations (e.g., `2 + 2`).
      Components that re-render often with new props.
    </when_not_to_use>
  </concept>

  <concept>
  useRef
    <use_case>
      Accessing DOM elements (e.g., focus input)
      Storing previous values (e.g., usePrevious hook)
      Timer/interval IDs (cleanup in useEffect)
    </use_case>

    <pitfalls>
      Not for state: Changes don’t trigger updates
      Null checks: Refs start as null (TypeScript helps)
    </pitfalls>

    <best_practices>
      DOM refs:
      ```jsx
      const inputRef = useRef(null);
      <input ref={inputRef} />;
      ```
      Mutable variables:
      ```jsx
      const renderCount = useRef(0);
      useEffect(() => { renderCount.current++ });
      ```
    </best_practices>

    <when_not_to_use>
      For state that should trigger re-renders (use `useState`)
    </when_not_to_use>
  </concept>

  <concept>
  React.lazy
    <use_case>
      Large components (e.g., modals, charts)
      Route-based splitting (with `react-router`)
    </use_case>

    <pitfalls>
      No SSR: Requires `Suspense`
      Loading states: Must handle fallback UI
    </pitfalls>

    <best_practices>
      With Suspense:
      ```jsx
      const LazyComponent = React.lazy(() => import('./HeavyComponent'));
      <Suspense fallback={<Spinner />}>
        <LazyComponent />
      </Suspense>
      ```
    </best_practices>

    <when_not_to_use>
      Small components (overhead > benefit)
    </when_not_to_use>
  </concept>

  <concept>
  usePrevious
    <use_case>
      Detecting State/Prop Changes:
      ```jsx
      const count = 5;
      const prevCount = usePrevious(count);
      // prevCount = undefined (first render), then tracks previous value
      ```
      Animations/Transitions: Compare old/new positions for smooth animations
      Debugging: Log previous vs. current values:
      ```jsx
      useEffect(() => {
        if (count !== prevCount) {
          console.log(`Count changed from ${prevCount} to ${count}`);
        }
      }, [count, prevCount]);
      ```
      Form Dirty Checks: Track if a form field was modified
    </use_case>

    <pitfalls>
      Initial Render Behavior: On the first render, usePrevious returns undefined (since no "previous" value exists)
      Fix: Handle the edge case explicitly:
      ```jsx
      const prevCount = usePrevious(count) ?? count; // Fallback to current value
      ```
      Stale Closures in Effects: If used inside useEffect, ensure dependencies include the previous value:
      ```jsx
      useEffect(() => {
        // Do something with prevCount
      }, [count, prevCount]); // ✅ Include prevCount
      ```
      Overuse: Not needed for most apps. Use only when comparing values is critical
    </pitfalls>

    <best_practices>
      Generic Hook: Make it reusable for any value type:
      ```jsx
      function usePrevious<T>(value: T): T | undefined {
        const ref = useRef<T>();
        useEffect(() => {
          ref.current = value;
        }, [value]);
        return ref.current;
      }
      ```
      Combine with useEffect for Side Effects: Example: Trigger an action only when a specific value changes:
      ```jsx
      const prevUser = usePrevious(user);
      useEffect(() => {
        if (prevUser?.id !== user.id) {
          fetchUserDetails(user.id);
        }
      }, [user]);
      ```
      Type Safety (TypeScript): Add types to avoid any:
      ```jsx
      const prevCount = usePrevious<number>(count);
      ```
    </best_practices>

    <when_not_to_use>
      For Derived Data: If the previous value can be computed from current props/state, avoid usePrevious:
      ```jsx
      // ❌ Unnecessary (derivable)
      const prevFullName = usePrevious(`${firstName} ${lastName}`);

      // ✅ Better (compute on demand)
      const fullName = `${firstName} ${lastName}`;
      ```
      High-Frequency Updates: For rapidly changing values (e.g., mouse position), `useRef` + `requestAnimationFrame` may be better:
      State Management: Use `useReducer` or Redux if you need history tracking (e.g., undo/redo).
    </when_not_to_use>
  </concept>
<concepts>

<other_references>
  Javascript Typescript `@~/.claude/docs/javascript_typescript.md`
</other_references>
