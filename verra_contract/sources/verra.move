module verra_contract::verra {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::table::{Self, Table};
    use sui::event;

    const EProfileAlreadyExists: u64 = 1;
    const EInsufficientRep: u64 = 2;
    const EStakeExceedsMax: u64 = 3;
    const EInvalidStake: u64 = 4;
    const EUnauthorized: u64 = 5;

    const STARTING_REP: u64 = 1000;
    const REP_FLOOR: u64 = 100;
    const MAX_STAKE_BPS: u64 = 2000;

    public struct PlayerProfile has key, store {
        id: UID,
        wallet: address,
        rep_score: u64,
        wins: u64,
        losses: u64,
        challenges_completed: u64,
    }

    public struct GameRegistry has key {
        id: UID,
        registered_games: Table<address, bool>,
    }

    public struct GameCap has key, store {
        id: UID,
        game_id: address,
    }

    public struct MatchRecord has key {
        id: UID,
        winner: address,
        loser: address,
        rep_transferred: u64,
        game_type: u8,
        timestamp: u64,
    }

    public struct ProfileCreated has copy, drop {
        wallet: address,
        rep_score: u64,
    }

    public struct MatchSettled has copy, drop {
        winner: address,
        loser: address,
        rep_transferred: u64,
        game_type: u8,
    }

    fun init(ctx: &mut TxContext) {
        let registry = GameRegistry {
            id: object::new(ctx),
            registered_games: table::new(ctx),
        };
        transfer::share_object(registry);
    }

    public fun create_profile(ctx: &mut TxContext) {
        let wallet = tx_context::sender(ctx);
        let profile = PlayerProfile {
            id: object::new(ctx),
            wallet,
            rep_score: STARTING_REP,
            wins: 0,
            losses: 0,
            challenges_completed: 0,
        };
        event::emit(ProfileCreated {
            wallet,
            rep_score: STARTING_REP,
        });
        transfer::transfer(profile, wallet);
    }

    public fun register_game(
        registry: &mut GameRegistry,
        ctx: &mut TxContext,
    ): GameCap {
        let game_id = tx_context::sender(ctx);
        table::add(&mut registry.registered_games, game_id, true);
        GameCap {
            id: object::new(ctx),
            game_id,
        }
    }

    public fun submit_result(
        _cap: &GameCap,
        winner_profile: &mut PlayerProfile,
        loser_profile: &mut PlayerProfile,
        stake: u64,
        game_type: u8,
        ctx: &mut TxContext,
    ) {
        assert!(stake > 0, EInvalidStake);
        assert!(loser_profile.rep_score >= REP_FLOOR + stake, EInsufficientRep);

        let max_stake = loser_profile.rep_score * MAX_STAKE_BPS / 10000;
        assert!(stake <= max_stake, EStakeExceedsMax);

        winner_profile.rep_score = winner_profile.rep_score + stake;
        winner_profile.wins = winner_profile.wins + 1;

        loser_profile.rep_score = loser_profile.rep_score - stake;
        loser_profile.losses = loser_profile.losses + 1;

        event::emit(MatchSettled {
            winner: winner_profile.wallet,
            loser: loser_profile.wallet,
            rep_transferred: stake,
            game_type,
        });

        let record = MatchRecord {
            id: object::new(ctx),
            winner: winner_profile.wallet,
            loser: loser_profile.wallet,
            rep_transferred: stake,
            game_type,
            timestamp: tx_context::epoch(ctx),
        };
        transfer::transfer(record, winner_profile.wallet);
    }

    public fun increment_challenges(profile: &mut PlayerProfile) {
        profile.challenges_completed = profile.challenges_completed + 1;
    }

    public fun get_rep_score(profile: &PlayerProfile): u64 {
        profile.rep_score
    }

    public fun get_wins(profile: &PlayerProfile): u64 {
        profile.wins
    }

    public fun get_losses(profile: &PlayerProfile): u64 {
        profile.losses
    }

    public fun get_wallet(profile: &PlayerProfile): address {
        profile.wallet
    }
}
