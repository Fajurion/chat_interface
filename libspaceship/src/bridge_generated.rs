#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.1.

use crate::api::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::rust2dart::IntoIntoDart;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

// Section: wire functions

fn wire_create_log_stream_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "create_log_stream",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || {
            move |task_callback| {
                Result::<_, ()>::Ok(create_log_stream(
                    task_callback.stream_sink::<_, LogEntry>(),
                ))
            }
        },
    )
}
fn wire_create_action_stream_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "create_action_stream",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || {
            move |task_callback| {
                Result::<_, ()>::Ok(create_action_stream(
                    task_callback.stream_sink::<_, Action>(),
                ))
            }
        },
    )
}
fn wire_start_voice_impl(
    port_: MessagePort,
    client_id: impl Wire2Api<String> + UnwindSafe,
    verification_key: impl Wire2Api<String> + UnwindSafe,
    encryption_key: impl Wire2Api<String> + UnwindSafe,
    address: impl Wire2Api<String> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "start_voice",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_client_id = client_id.wire2api();
            let api_verification_key = verification_key.wire2api();
            let api_encryption_key = encryption_key.wire2api();
            let api_address = address.wire2api();
            move |task_callback| {
                Result::<_, ()>::Ok(start_voice(
                    api_client_id,
                    api_verification_key,
                    api_encryption_key,
                    api_address,
                ))
            }
        },
    )
}
fn wire_test_voice_impl(port_: MessagePort, device: impl Wire2Api<String> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "test_voice",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_device = device.wire2api();
            move |task_callback| Result::<_, ()>::Ok(test_voice(api_device))
        },
    )
}
fn wire_stop_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "stop",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(stop()),
    )
}
fn wire_set_muted_impl(port_: MessagePort, muted: impl Wire2Api<bool> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "set_muted",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_muted = muted.wire2api();
            move |task_callback| Result::<_, ()>::Ok(set_muted(api_muted))
        },
    )
}
fn wire_set_deafen_impl(port_: MessagePort, deafened: impl Wire2Api<bool> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "set_deafen",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_deafened = deafened.wire2api();
            move |task_callback| Result::<_, ()>::Ok(set_deafen(api_deafened))
        },
    )
}
fn wire_is_muted_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, bool, _>(
        WrapInfo {
            debug_name: "is_muted",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(is_muted()),
    )
}
fn wire_is_deafened_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, bool, _>(
        WrapInfo {
            debug_name: "is_deafened",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(is_deafened()),
    )
}
fn wire_set_amplitude_logging_impl(
    port_: MessagePort,
    amplitude_logging: impl Wire2Api<bool> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "set_amplitude_logging",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_amplitude_logging = amplitude_logging.wire2api();
            move |task_callback| Result::<_, ()>::Ok(set_amplitude_logging(api_amplitude_logging))
        },
    )
}
fn wire_is_amplitude_logging_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, bool, _>(
        WrapInfo {
            debug_name: "is_amplitude_logging",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(is_amplitude_logging()),
    )
}
fn wire_set_talking_amplitude_impl(port_: MessagePort, amplitude: impl Wire2Api<f32> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "set_talking_amplitude",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_amplitude = amplitude.wire2api();
            move |task_callback| Result::<_, ()>::Ok(set_talking_amplitude(api_amplitude))
        },
    )
}
fn wire_get_talking_amplitude_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, f32, _>(
        WrapInfo {
            debug_name: "get_talking_amplitude",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(get_talking_amplitude()),
    )
}
fn wire_set_silent_mute_impl(port_: MessagePort, silent_mute: impl Wire2Api<bool> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "set_silent_mute",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_silent_mute = silent_mute.wire2api();
            move |task_callback| Result::<_, ()>::Ok(set_silent_mute(api_silent_mute))
        },
    )
}
fn wire_create_amplitude_stream_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "create_amplitude_stream",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || {
            move |task_callback| {
                Result::<_, ()>::Ok(create_amplitude_stream(
                    task_callback.stream_sink::<_, f32>(),
                ))
            }
        },
    )
}
fn wire_delete_amplitude_stream_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "delete_amplitude_stream",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(delete_amplitude_stream()),
    )
}
fn wire_list_input_devices_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, Vec<InputDevice>, _>(
        WrapInfo {
            debug_name: "list_input_devices",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(list_input_devices()),
    )
}
fn wire_get_default_id_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "get_default_id",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(get_default_id()),
    )
}
fn wire_list_output_devices_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, Vec<OutputDevice>, _>(
        WrapInfo {
            debug_name: "list_output_devices",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Result::<_, ()>::Ok(list_output_devices()),
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}

impl Wire2Api<bool> for bool {
    fn wire2api(self) -> bool {
        self
    }
}
impl Wire2Api<f32> for f32 {
    fn wire2api(self) -> f32 {
        self
    }
}
impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

// Section: impl IntoDart

impl support::IntoDart for Action {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.action.into_into_dart().into_dart(),
            self.data.into_into_dart().into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Action {}
impl rust2dart::IntoIntoDart<Action> for Action {
    fn into_into_dart(self) -> Self {
        self
    }
}

impl support::IntoDart for InputDevice {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.id.into_into_dart().into_dart(),
            self.sample_rate.into_into_dart().into_dart(),
            self.best_quality.into_into_dart().into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for InputDevice {}
impl rust2dart::IntoIntoDart<InputDevice> for InputDevice {
    fn into_into_dart(self) -> Self {
        self
    }
}

impl support::IntoDart for LogEntry {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.time_secs.into_into_dart().into_dart(),
            self.tag.into_into_dart().into_dart(),
            self.msg.into_into_dart().into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for LogEntry {}
impl rust2dart::IntoIntoDart<LogEntry> for LogEntry {
    fn into_into_dart(self) -> Self {
        self
    }
}

impl support::IntoDart for OutputDevice {
    fn into_dart(self) -> support::DartAbi {
        vec![self.id.into_into_dart().into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for OutputDevice {}
impl rust2dart::IntoIntoDart<OutputDevice> for OutputDevice {
    fn into_into_dart(self) -> Self {
        self
    }
}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

#[cfg(not(target_family = "wasm"))]
#[path = "bridge_generated.io.rs"]
mod io;
#[cfg(not(target_family = "wasm"))]
pub use io::*;
