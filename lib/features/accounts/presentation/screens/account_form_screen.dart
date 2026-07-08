import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/finance/account_types.dart';
import '../../../../core/finance/bank_info.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/dropdown/pocket_dropdown.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../../../../shared/layouts/form_section.dart';
import '../providers/account_provider.dart';
import '../providers/add_account_notifier.dart';
import '../providers/account_form_provider.dart';
import 'package:flutter/services.dart';
import '../../domain/models/account.dart';

class AccountFormScreen extends ConsumerStatefulWidget {
  final Account? account;

  const AccountFormScreen({
    super.key,
    this.account,
  });

  @override
  ConsumerState<AccountFormScreen> createState() =>
      _AccountFormScreenState();
}

class _AccountFormScreenState
    extends ConsumerState<AccountFormScreen> {

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _accountNameController;
  late final TextEditingController _accountNumberController;
  late final TextEditingController _balanceController;
  late final FocusNode _accountNameFocusNode;
  late final FocusNode _accountNumberFocusNode;
  late final FocusNode _balanceFocusNode;

  @override
  void initState() {
    super.initState();

    _accountNameController = TextEditingController();
    _accountNumberController = TextEditingController();
    _balanceController = TextEditingController();

    _accountNameFocusNode = FocusNode();
    _accountNumberFocusNode = FocusNode();
    _balanceFocusNode = FocusNode();

    if (widget.account != null) {
      final account = widget.account!;

      _accountNameController.text = account.accountName;
      _accountNumberController.text = account.accountNumber;
      _balanceController.text =
          account.balance.toStringAsFixed(2);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier = ref.read(addAccountProvider);

        notifier.setBank(account.bankCode);
        notifier.setAccountType(account.accountType);
      });
    }
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _balanceController.dispose();
    _accountNameFocusNode.dispose();
    _accountNumberFocusNode.dispose();
    _balanceFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveAccount(
      AddAccountNotifier notifier,
      ) async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (notifier.selectedBank == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a bank.'),
        ),
      );
      return;
    }

    if (notifier.selectedAccountType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an account type.'),
        ),
      );
      return;
    }

    if (widget.account == null) {
      await notifier.saveAccount(
        accountName: _accountNameController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
        openingBalance: double.parse(
          _balanceController.text.trim(),
        ),
      );
    } else {
      await notifier.updateAccount(
        account: widget.account!,
        accountName: _accountNameController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
        openingBalance: double.parse(
          _balanceController.text.trim(),
        ),
      );
    }

    await ref.read(accountProvider).loadAccounts();

    if (!mounted) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {

    final notifier = ref.watch(addAccountProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.account == null
                ? 'Add Account'
                : 'Edit Account',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  FormSection(
                    title: 'Account Information',
                    children: [

                      PocketDropdown<String>(
                        label: 'Bank',
                        prefixIcon: const Icon(
                          Icons.account_balance_outlined,
                        ),
                        value: notifier.selectedBank,
                        validator: Validators.dropdown,
                        onChanged: notifier.setBank,
                        items: BankInfo.supportedBanks
                            .map(
                              (bank) => DropdownMenuItem(
                            value: bank,
                            child: Text(
                              BankInfo.getName(bank),
                            ),
                          ),
                        )
                            .toList(),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      PocketDropdown<String>(
                        label: 'Account Type',
                        prefixIcon: const Icon(
                          Icons.credit_card_outlined,
                        ),
                        value: notifier.selectedAccountType,
                        validator: Validators.dropdown,
                        onChanged: notifier.setAccountType,
                        items: AccountTypes.values
                            .map(
                              (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ),
                        )
                            .toList(),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      PocketTextField(
                        controller: _accountNameController,
                        focusNode: _accountNameFocusNode,
                        prefixIcon: const Icon(
                          Icons.badge_outlined,
                        ),
                        label: 'Account Name',
                        hint: 'Salary Account',
                        validator: Validators.requiredField,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _accountNumberFocusNode.requestFocus();
                        },
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      PocketTextField(
                        controller: _accountNumberController,
                        focusNode: _accountNumberFocusNode,
                        prefixIcon: const Icon(
                          Icons.pin_outlined,
                        ),
                        label: 'Account Number',
                        keyboardType: TextInputType.number,
                        validator: Validators.accountNumber,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onFieldSubmitted: (_) {
                          _balanceFocusNode.requestFocus();
                        },
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      PocketTextField(
                        controller: _balanceController,
                        focusNode: _balanceFocusNode,
                        prefixIcon: const Icon(
                          Icons.currency_rupee,
                        ),
                        label: 'Opening Balance',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: Validators.amount,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                        onFieldSubmitted: (_) => _saveAccount(notifier),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xxxl),

                  PocketButton(
                    label: widget.account == null
                        ? 'Add Account'
                        : 'Update Account',
                    loading: notifier.loading,
                    onPressed: () => _saveAccount(notifier),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}