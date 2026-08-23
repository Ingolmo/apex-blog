# APEXlang article laboratory

## Required context

- Read the relevant Oracle APEX/APEXlang skill before inspecting or changing APEXlang.
- Read the relevant Oracle Database skill before inspecting or changing database source.
- Use only the change specification explicitly selected by the user. Do not combine or infer requirements from another specification.

## Working rules

- Treat `applications/` as the only active APEXlang source tree.
- Treat `baseline/` as the immutable initial export. Preserve accepted intermediate states with a recoverable Git commit or an explicitly named checkpoint.
- Before editing, resolve the target application, identify the active specification and present the bounded files and components expected to change.
- Keep changes small and reviewable. Do not broaden the active specification or modify unrelated pages, components, database objects, navigation, security or application behavior.
- Never overwrite an export tree that contains unreviewed local changes.
- Do not modify `.apex/apexlang.json` manually; read and preserve its `mmdVersion`.
- Do not store passwords, tokens, wallets, connection configuration, private URLs or other secrets in the project, commands, screenshots or logs.
- Do not add generated logs, screenshots, binaries or support files unless they have a defined reproducibility or editorial purpose.

## Execution gates

- Do not execute direct DDL, ad hoc DML, database install/teardown scripts or APEX imports unless the user grants separate, explicit approval for that action.
- APEXlang validation is allowed when it is part of the active specification. After validation, stop and show the complete diff.
- A successful validation does not authorize import.
- When import is explicitly approved, validate and import exactly the reviewed source tree in the same authenticated SQLcl session.
- Functional browser tests may change only synthetic laboratory rows required by the approved cases. Restore temporary values and report any residue.
- Do not commit, tag, push or publish unless explicitly requested.
