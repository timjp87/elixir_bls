extern crate amcl;
#[macro_use]
extern crate rustler;
extern crate rustler_codegen;
#[macro_use] extern crate lazy_static;
extern crate rand;

use rustler::{Env, Term};

rustler_export_nifs! {
    "Elixir.Bls",
    [
    ("new_kp", 0, Keypair::random),
    ("sign", 3, Signature::new),
    ("verify", 4, Signature::verify),
    ("new_sk",0, SecretKey::random_nif),
    ("new_sk_from_bytes", 1, SecretKey::from_bytes_nif),
    ("sk_to_bytes", 1, SecretKey::as_bytes_nif),
    ("pk_from_sk", 1, PublicKey::from_secret_key_nif),
    ("pk_to_bytes", 1, PublicKey::as_bytes_nif),
    ("asig_new", 0, AggregateSignature::new_nif),
    ("asig_add", 2, AggregateSignature::add_nif),
    ("asig_verify", 4, AggregateSignature::verify_nif),
    ("asig_to_bytes", 1, AggregateSignature::as_bytes_nif),
    ("agpk_new", 0, AggregatePublicKey::new_nif),
    ("agpk_add", 2, AggregatePublicKey::add_nif),
    ("asig_add_aggregate", 2, AggregateSignature::add_aggregate_nif),
    ("agpk_add_aggregate", 2, AggregatePublicKey::add_aggregate_nif),
    ("agpk_to_bytes", 1, AggregatePublicKey::as_bytes_nif),
    ("agpk_from_bytes", 1, AggregatePublicKey::from_bytes_nif)
    ],
    Some(on_load)
}

fn on_load(env: Env, _info: Term) -> bool {
    resource_struct_init!(PublicKey, env);
    resource_struct_init!(SecretKey, env);
    resource_struct_init!(Signature, env);
    resource_struct_init!(Keypair, env);
    resource_struct_init!(AggregatePublicKey, env);
    resource_struct_init!(AggregateSignature, env);
    true
}

mod aggregates;
mod amcl_utils;
mod errors;
mod g1;
mod g2;
mod keys;
mod rng;
mod signature;

use self::amcl::bls381 as BLSCurve;

pub use aggregates::{AggregatePublicKey, AggregateSignature};
pub use errors::DecodeError;
pub use keys::{Keypair, PublicKey, SecretKey};
pub use signature::Signature;