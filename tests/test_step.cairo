use super::utils::deploy_contract;
use workshop::counter::{ICounterDispatcher, ICounterDispatcherTrait, CounterContract};
use snforge_std::{spy_events, EventSpyAssertionsTrait};

#[test]
fn test_counter_event() {
    let initial_counter = 15;
    let contract_address = deploy_contract(initial_counter);
    let dispatcher = ICounterDispatcher { contract_address };

    let mut spy = spy_events();
    dispatcher.increase_counter();

    spy.assert_emitted(@array![
        (
            contract_address,
            CounterContract::Event::CounterIncreased(
                CounterContract::CounterIncreased { value: 16 }
            )
        )
    ]);

}
